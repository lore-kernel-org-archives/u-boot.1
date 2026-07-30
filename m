Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06ED5C55165
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 13:36:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C60A081016;
	Thu, 30 Jul 2026 13:36:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UNccRK_EQN-1; Thu, 30 Jul 2026 13:36:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C403180F6B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785418570;
	bh=XyRNCatzNE+CVe+3OvjRmxRZ9Z1PArP6jvrWXSLSam4=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZtPev3sYEtAg2kmw0oJFTAuLqM7ZUyPWTns6soU4A2khF2L4mMB+hz1b4+w38DDco
	 hcy6o0gim/FIrQnWkgDfWDxVcfE0aPdTVj9rFKa7K2GIOVkrivvRwGXrAcGns9IwIq
	 9XjB5RwQwhWWfaoQmVxGed0yaOmpFmiVFZc2TYkAFqb0uhwJ72iYwkv2CpyXq9Ny0+
	 uzmVWZIf/6YQD7TrMzPJ2eJRcuvMbXbybq0mA1Sq5W7OgQiBYi/7fh9L7EDmII9Yah
	 uodiqMiO+cQplUzORoNw02ecgx6Ceh6YFu39FaiEpR7X8xzINNLbkFeNqp8XjS+J63
	 +GaC6G7lzzS3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C403180F6B;
	Thu, 30 Jul 2026 13:36:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B41D197
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:36:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E555760895
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:36:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nhhvX8dJjUed for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 13:36:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A6C3D6085F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A6C3D6085F
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A6C3D6085F
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:36:08 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-69f734cd461so303656a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418567; x=1786023367;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XyRNCatzNE+CVe+3OvjRmxRZ9Z1PArP6jvrWXSLSam4=;
 b=M4NrUTkHtth6xso3OaXhxRVCFM5VPIokiZhBBYbmwyfZFxci9wPx72j4C0TcjotJKc
 1W+Hhg9sOHFJBgdAcK4Zg70P8n5G+nG3/D2BsT8poiU3tpIVB8imOAsmiILDQxGwMv5i
 /mo8IapHoFok74H9ARY1HrWDV78DQ3l/A9ZRizn4C3oZxp0siGOa215Z5RoF/GiqUOJN
 7NZtctJAe9Re4ZG76b+CdMnwWW8YXc/CvbLN/mTlSHDO2ZF8u6mFNPtXjdF5qyGxpj5Q
 3ZSnuLnhldKg/WRuFLdyTMcJKA3tv6w5/jcYJEXtwA5eXzdgAgH/6SI1HBYLqQ3M9Tqt
 c/FA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq0T7Y/w8UGVWSdP35P+62MhIdVgxWDeINaQvNaPXFU3jjAmeJICcRUltf6EFMjEqBPk8MVXSk=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx5S99Huy1q+MGdM4WUxawxvjxXff5Jup8sK5+PukcR/P43zbzO
 VVIcvnHiMEkfKx2Ug+MEW3GpdFqLnd6ImscQ+lBGXWhJ/FjHDV9q7xeQ
X-Gm-Gg: AR+sD12TbFWbg2CFNiyn7Zj6SybKJ7kDVyvvuKTSca3P751m9BcZVkEdGPaNwNJ8Oe1
 tRVv7y1/s5OV33Qg+Aaz02CH9YyLrtJ2MHkwIoJ40zp8ij+QR+N+HDc0fGk9bPUH5qB13vXRDb8
 raoVzV6OEGJEPTAh+gVnzo4FtRQiejyHM9mCrwetH1SkYtJsDpCAZ+1RlYXqWs61s5bzvwESCqu
 /66Ru7Aq/OU36VYh2324ik8m0WfFqJ6HOR+R0JTtcUNprUycHWRibfVKLTgYOh6GCPqTPGcU21Y
 moyjbwQ18RVOuvCtfg6QySe+6AROWAc3y12t5jVElygTBsnYqH/ny0f2ocpH/Qiwpy05ESbmlo0
 Dsne4TtBmEpfnYFT7cPN6On2A5Pia+feQ6D7/NbWub+nCl2ZdZMFzod8NRjqwdMFt9Bgcdkf870
 DQt88v+o1AfDaA9QyBcw6AFOxBxjUI+ApHDGTRYSCc+ZNnUGG3xxXds5k4QsomHAtleErrkE3v5
 GBfn5NOiBS0NESgy0LuWgCXefk=
X-Received: by 2002:a05:6402:915:b0:69c:794d:4866 with SMTP id
 4fb4d7f45d1cf-6a090d5a301mr183760a12.4.1785418566522; 
 Thu, 30 Jul 2026 06:36:06 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a07d3a2914sm599087a12.27.2026.07.30.06.36.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 06:36:06 -0700 (PDT)
Message-ID: <6ffd84d3-3e5e-4f11-bd64-eb69051e5b2e@gmail.com>
Date: Thu, 30 Jul 2026 15:36:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 11/12] rockchip: doc: rockusb: remove refer to
 README.rockchip
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785418567; x=1786023367;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XyRNCatzNE+CVe+3OvjRmxRZ9Z1PArP6jvrWXSLSam4=;
 b=rZmXUyoWG2uYIWWhlRY1EVKa94UPon8HSYM9GMj0TTNg2JX7mfbPq/s4qHRHeIOpnt
 tBFVPy2Q29tuh14ziAQ9x4/4ThHRK+FCXEEFTx29x0qbDbJDk+ROQdjjeGBJKiRlZ+Gr
 1PPKrVqfiyIP/G+dWbJBvKqJK0S9r++SDY8bXZiwujqU9CRgq/7Yw/6Q0l94OkHwVqYD
 /9H8TU0EvzcpaDeE01b4yBxMY8EdSpAmlCMFfXZCd9Q53e74t00mopamFmSSC1yq0/cp
 xTMKY/Yq+yxUap7J1bDLYa9BAoXg8Ifv5j8EHODpKLWAtWfGf4dz7/3QSvluxRD37pYB
 YmkQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=rZmXUyoW
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

README.rockchip must be removed.
Remove the refer to README.rockchip in README.rockusb

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 doc/README.rockusb | 1 -
 1 file changed, 1 deletion(-)

diff --git a/doc/README.rockusb b/doc/README.rockusb
index 66437e17e46b..5b96467689b7 100644
--- a/doc/README.rockusb
+++ b/doc/README.rockusb
@@ -38,7 +38,6 @@ you want to write.
 sudo rkdeveloptool wl  <BeginSec> <File>

 to flash U-Boot image use below command. U-Boot binary is made by mkimage.
-see doc/README.rockchip for more detail about how to get U-Boot binary.

 sudo rkdeveloptool wl  64 <U-Boot binary>

--
2.39.5

