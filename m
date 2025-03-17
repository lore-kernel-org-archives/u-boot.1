Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20E9C35FF8
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 16:16:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4179981A0C;
	Mon, 17 Mar 2025 17:16:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Eq/CyNE/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49F8F8198F; Mon, 17 Mar 2025 17:16:33 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 534B580F70
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 17:16:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3913958ebf2so3683206f8f.3
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 09:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742228191; x=1742832991; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VGyo76a0+PpdYumrk7TVfB4l/fgJeQFKkD3hzP3nWA8=;
 b=Eq/CyNE/q8m9/LIVA2LBFPaq+RB3ecnuf9I/nnmTF+2ZScXZPu+Ah2JnvC2A+0SzqY
 a82Eu4+EgA6HfDRVsl4z6b6cSg4tun1lPQiVMaGhynMhJhigyqlJbvNqRx8pij0HU6R6
 nfyY0tz2eADnHzRXeGidn0Sv28ZWu6OTcpXKkjx5nYgTrEEqzQTfmPK2K7DPwahA2/gE
 5A524k4VE3L9oYpYMOtZyUPV94lxe+Ik22J8HliQMgs3KTo0gc3pWIzDhboK3JqxzX6S
 dHGhvgw129Yj9YneHASDw+NX6CRJAO2GzIv5oam0Xh2jMiQVeks9E4RV1/SBc2zn3noF
 UZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742228191; x=1742832991;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VGyo76a0+PpdYumrk7TVfB4l/fgJeQFKkD3hzP3nWA8=;
 b=d0g+5RM2jLDB1B87MySmTqJa7srj969nzXUosWuSVnFeZDEY2LjhTNciLa5hzTv4R4
 wr2+dyDEJqtvyMCJuqU+brYlkuLHjpXRKuKi9iJay8nl9RCAm4yeBGds6rdmKSP9sX9s
 mFeAC1waCFL3LHFLQ7ga/qEhoZjINN08T6vvc7AVhxYbftIcBXVcj+kAdriKVivBPrq+
 S8spovtBup/r2OtW+wuuujJWLnIyFek0wKZgHfCQRFvvyR9WAqAEtnlHymodZ43uVl3S
 hR5MKzQw1pPXhTc2VBO8zK/Fw+xOAwYa74ER4ICsK9jfSPHw7fO1sakiq4R2zfFm3AW6
 mOBw==
X-Gm-Message-State: AOJu0YwrrsAg+/m7l2D4rUH2l5b/4d0leru3o1qC9VdlwMkzTNiC6gwd
 6Ftb7Vhf6zWDDjhLvEn0bqwlx6OwKoZEpzOWpqOJNTuJOwU0RBzxZ7UL9ieXmFIZ3qev5Eu9bYH
 o
X-Gm-Gg: ASbGncuaiCatA56WqjwsrAmufMCQE6bJKwhCSC3cgWRCyQu9ZRrVD/4E3QdSj0vBXux
 eWbEQHCEzBaPIQgeepv2GP1sDs047f6IKnfkxNJBTYGmzb0OsUbL3SIdCmaVBnzogLNK3Xsjq74
 D8FkxkX9GB0a56Ftsrt/gp1QDRN3YEm6/315HD6sbGbD29mtMOkqx5HvWTCeFKQnjbdn6F7eDK0
 gz8a8mYSUREiyanibbR5KCTM4chOrtEGwb5ILSOMywNCbiSoqiiIVoYJkJvnyK9wKoibsdhg3JQ
 jXD2T1yhEOmcOYfmWydkMGA08qpwbd70SBQUWm4aSP+ZGhVayF88aZPwi9WWtdquUMrzRBJEpTa
 rOQivU44vWrhnd3EDiFLd3A==
X-Google-Smtp-Source: AGHT+IG7xGJ9SVF5bYJNgk2iA3mJw+07aLGeJcM1t24gnP1juxYq80Tn6sROyhcKiGoj4WOEX+YjrA==
X-Received: by 2002:a05:6000:188d:b0:391:13ef:1af8 with SMTP id
 ffacd0b85a97d-3996b4a2577mr206831f8f.54.1742228190786; 
 Mon, 17 Mar 2025 09:16:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:ee7:da01:297:ab8d:44c0:c2e1?
 ([2a0a:ef40:ee7:da01:297:ab8d:44c0:c2e1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c7df31f6sm15341206f8f.6.2025.03.17.09.16.30
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 09:16:30 -0700 (PDT)
Message-ID: <af0f0e52-2891-4b56-a7dd-0804f86770aa@linaro.org>
Date: Mon, 17 Mar 2025 16:16:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [RFC] memtest
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

As far as I can tell no one makes any use of 
test/py/tests/test_memtest.py. At least there is no entry in 
u-boot-hooks that will enable its use.

This is not surprising as the code does not actually work correctly. It 
will construct a command line for the 'mtest' command with some decimal 
parameters and some in hex. 'mtest' will interpret all parameters as hex 
and this makes the test fail for almost anything apart from the trivial 
cases where the affected parameters are 0.

I looked into this for a while before I found the documentation that 
describes memory testing which states that 'mtest' is deprecated.

So my question is should I submit a patch to fix the test even though 
the command itself is deprecated? Should I then enable its use in CI? 
Alternatively should I submit a patch to remove the test as it is not 
used and is broken?

If the test should be removed a follow up question would be should the 
command itself be removed as well? This will be harder to do as it seems 
that some boards are using the config default values in their board code.

Andrew
