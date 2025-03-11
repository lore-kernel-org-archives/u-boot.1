Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A267C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 22:56:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C3E98083E;
	Tue, 11 Mar 2025 23:56:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kw79B1vd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8492F80F92; Tue, 11 Mar 2025 23:56:36 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DA2380756
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 23:56:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4769bbc21b0so14551941cf.2
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 15:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741733792; x=1742338592; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ECkRL2TxC/OZ9Z47NcFS8rTvCWcm+hNq8VxHXXAYWms=;
 b=kw79B1vdp+u71gKkSkur0rI0MRNFiIbS1pXKMk+87srKGGyO7yr1xuYrreNnW74sQY
 dMaS5Ua1Hv7jHlySc15FpAQc7j1nGauGKHvxhoTUUnPx+g/SNXXt/CgpoZtW4Q0uL0bA
 kaOwXC8xKaZvYdjDCzps0wQBY/U4u6/bMpO0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741733792; x=1742338592;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ECkRL2TxC/OZ9Z47NcFS8rTvCWcm+hNq8VxHXXAYWms=;
 b=TD5daN/pxWf3lqEtk06QLPp6HeKin2zvnDHlfEV5yNfxoAUHrj3Uv+xzgMuyiqQ/AP
 hGSgGVdrXiK0sCg1mjvN/h1u7dvKj10Vmq5nunIce9EtN7CfLT9EkD4RUwgQlwT0pQ7+
 klnKmRRhDq/TewjDlqXi3XDtopPZectM7NOt7ih4iXXBCfog2uAJwoV9bdgKsLJu09sc
 XdCY3Z+Zyn/yM4XDoOA6fMSXpnjYDLqjwHUySUfzBg+dxmqDjWCK36VUZxBS1dCTPo8h
 mXV1zsSyV0NrFpPuYZ0P77wh/qE2sWRD9Rvu45mrNY/S0spSOLzT8Wqhu9YptilJZ8gn
 vZFQ==
X-Gm-Message-State: AOJu0YyOoWj07fBvOloOpV8DiiKNfzsJKMHV4swIsxXUFm5+0ZvMgZKc
 5Ks4LsHtRxhcE5vyJf+i+ifuoPRf4robBWb8HDy0d1jFH3XsmRadnZ8PtQehwHuoL7VPPFn5bsx
 K
X-Gm-Gg: ASbGncuYBySL5l5vgB4hu4vCcEr7BEctYmcGUSJdTwYSOSBtLkOzMJoCXKLLAeP0Nf3
 i962lN16B1SaCstJJ3btsYCXeIlAfbvkiBbSDwTe6VByQwUrp54oXSAt2o/RxLHis1IaR/BnG1a
 FxTcPWceQVYTCmzakuK6QLl5ocBi4RW+HYGqOSsmcSWvY4I6c1qLEa4F93AUVTcPjrgr5SS0mJT
 Jh/Gjs36W411e+AlZSnOJ44Sfv9lwr8iOfKnqThbR70yGYm/cl914zK7tckqQtramynXULXwLeK
 TF0+HppOD73jyHm9+leDD3K94C4uXs1N9BAAO4Go2gTf
X-Google-Smtp-Source: AGHT+IH8+vN4QnfMHkLsTXFJ3MwyPv4x5pRDlHNxxNTwGDCw7AWpPzDAYhS2aGTlLYnSAbXYbMxTQg==
X-Received: by 2002:ad4:5aac:0:b0:6d8:80e8:d567 with SMTP id
 6a1803df08f44-6e9005f732emr305941216d6.18.1741733792594; 
 Tue, 11 Mar 2025 15:56:32 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f7090cedsm76855456d6.47.2025.03.11.15.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 15:56:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <21159101-d1f3-4a72-b065-e4e0de3609c8@linaro.org>
References: <21159101-d1f3-4a72-b065-e4e0de3609c8@linaro.org>
Subject: Re: Please pull net-next-20250310
Message-Id: <174173379105.1662568.6952794380838524959.b4-ty@konsulko.com>
Date: Tue, 11 Mar 2025 16:56:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 11 Mar 2025 15:29:52 +0100, Jerome Forissier wrote:

> The following changes since commit 1b42f57ec82ceba4d5f08cfb359717232301cfa5:
> 
>   Merge tag 'v2025.04-rc4' into next (2025-03-10 20:18:51 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-next-20250310
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


