Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D2FC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 09:13:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07906807E4;
	Fri, 24 Jan 2025 10:13:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UpRMWWbU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AF50807FE; Fri, 24 Jan 2025 10:13:14 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F016F80780
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 10:13:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d3f65844deso3326775a12.0
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 01:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737709991; x=1738314791; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E30BpjYpBMHJ6t9oYucVC7bUJE3bqa4aRmnKcEp9BUs=;
 b=UpRMWWbUeg1WgEMxbKBqvTvIbPcO+Ic5SSoHttY9BSiRMPof7zfoijSHlxTP+hq0TM
 6/ahphDPLsv2a76DRYDso4JlPLj7ZmjRCJ5lNewka4H2gwBRUnIyoOFGgvE/vIq/wp9N
 de2MgEGlrHSrQzrPjhON3zh38y7DR0qdOEw4HR6sMQcE56W0lrpWb1a5r+eEQnvnP08W
 K8Zw3Xeq8Mm1XSiH9tlfmgtZ67ALdu8dpIe8y2Qt/DDpZmksPocRP6547T5RYWbY8jAs
 a0uNp7Jjl5+lwfHN0jnR8+fbn98OXZdtf+ct1va6/dVPIRto5s+ngiMhRYok/Q8Fz+fZ
 Vj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737709991; x=1738314791;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E30BpjYpBMHJ6t9oYucVC7bUJE3bqa4aRmnKcEp9BUs=;
 b=Z3rePPmKrpILLjoQKt82JjfKJEiIsLEyo22MiIfvsw9tv0pO8cvHy89V6ByHPWG2RH
 zCnaBxboIflc734BMPCfs3CNe04evO7WUSSaBLz2+cU/cZOj6kv/sxaT0C+TfVD3JEs9
 bpKg821Rv3Rs3gdkOPYfuUNL4hLfwPe5l+9L7dBd8Dgs7r4eyq6llAQQK4i9CbfsxcRS
 XgjOQZ30/PVAWdQf3gap8N8hKXXIynGy2hKMMfD+KsAFOtXau5wA4ymoqDGoeg4toeBX
 JNHwfzoVBaAm/ovNAyuXXJ35ng/UQu0bBMyy+yaBy6Mr0DbZQdvZVinirJ7Q/qFfFfdl
 aSQA==
X-Gm-Message-State: AOJu0YyD0L2IAbDKNRPWD2erNkStt+zr86j28s1KWkK/nOq+JMSEn8ZH
 AvDwMw7GRVn9+fG226EIbDZhTB9cRuOjFiTormwn5P63OPX52tbt/BBAWZZ+WxocLZEl9iyUySe
 9dHRZ2g==
X-Gm-Gg: ASbGncsAkUFXhatsnzPXqFfK57jI923y30I7MChmzWwdASk8P0Dyb8FRuCeNLa6b9cS
 XKkL1Dn72BdfCN8zBnNnvC0ga2tqE4RW+NE6Ht238CnzOtGl9sxJJglLZKFJBp24/eAzterOWv7
 9Mc8zV4Jy4/Anh7MzbxPQ1s0W80afTA4CiEsJIhbSENFCJ9o4MTenK8OdHeFF+5rgSgIj26pCA4
 9CZgY4rJ9+EO4mBxZi0pMgjWldX6kxIeTbaqzW9s4aLbdXpFJSMWjNxmuCQWuskR+dHSzFcy8vV
 Rs0CGFwAmntu+HVqxPyzWYOdfLS+YKsFIo0hX/q/cUpGeEB3ZKHICsxdWM9a
X-Google-Smtp-Source: AGHT+IFg6dp5GWonNB+fqQ0jZTogv+tueycMyQ+CjFv7JpdcMDrznRPmGhyohqWsARdQF7HpPDbqDA==
X-Received: by 2002:a05:6402:84f:b0:5d0:e615:39fe with SMTP id
 4fb4d7f45d1cf-5db7d31909amr27781264a12.18.1737709991081; 
 Fri, 24 Jan 2025 01:13:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:3f81:732e:4183:39c7?
 ([2a01:e0a:3cb:7bb0:3f81:732e:4183:39c7])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc18638ed2sm895530a12.36.2025.01.24.01.13.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 01:13:10 -0800 (PST)
Message-ID: <3d87e518-cfda-49ca-8bf7-743c9bbf6e72@linaro.org>
Date: Fri, 24 Jan 2025 10:13:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Static initcalls
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <cover.1737709089.git.jerome.forissier@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <cover.1737709089.git.jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

On 1/24/25 10:10, Jerome Forissier wrote:
> Re: [PATCH v2 0/3] Static initcalls

Apologies for the wrong reroll count. This is actually v5 as mentioned in the
change log.

-- 
Jerome
