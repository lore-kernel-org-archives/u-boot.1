Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93504CDB465
	for <u-boot@archiver.kernel.org>; Sat, 14 Oct 2023 04:26:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0330280090;
	Sat, 14 Oct 2023 06:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bwRdaSI4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE97486EF1; Sat, 14 Oct 2023 06:23:11 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 201EC86611
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 06:21:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-53e3b8f906fso2431534a12.2
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 21:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697257277; x=1697862077; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SKi8W0SqVsZ2309h+O02h0w08+poAR/Saiq0CHhTSEM=;
 b=bwRdaSI4cJytwC+WqLNRjFTIC22o0wtRoNiBOWrZMldgKW7yy3e+GN/Ckheva/M9OZ
 WnOxk5Dj3Ag4Mozz24PQMCjGYCBv5Q0K05LMAuctV7gKhvmza+eD94ygAUlDHzGXP5d2
 Sz0h0UvnMYNpkWQKwG4xdkZUvCD49Hcd9TmVPmOeCdH10l8uPjNi00Nx8XSXF6grmcRs
 YlUQwn+dLAs6xNsX2Tk6/R74H49mg1o6pBuELhD+/toEuhk/2/NjvL/t9yqqZb+x0DAs
 Ced8O2w77sDtwh+S0MNBhPewAHaeLBN1i+L4D/pDrASFON+dBrJRDjQLqBwzOp+sAxNn
 Lvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697257277; x=1697862077;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SKi8W0SqVsZ2309h+O02h0w08+poAR/Saiq0CHhTSEM=;
 b=nEE6WrUOVwLyI6TJlWdIyceunAaOWgq8c5jjlFKKBqu1HB9r0OC1MtVO1IO/2f1DP1
 ddl+5ieXMfI7u6qxAWDx8tRXGJiPE7T93YEwvBGQ1H46+nFqDTP/sqeoDku2urg+p+LT
 LlM3c2h+w3VZd7snPkCLjI8SOKzFu/mhXuTpvVTvA7uLQoSK23nVrmuI9EJOPZWVktwz
 YQeyd6GpgfYMj486XO4EEnJb4MMPqJskcO4Jf/O9m9ahXZN2s1x9DzSd55GxCUIZ9BzR
 nOhdmC9qu2/sVZAoY25TmQTr/bJrncH/uQmJSFFnZUOb9hD+UMK30D88qCIc6yKcFWJK
 2I2Q==
X-Gm-Message-State: AOJu0YwlzY0Vz75E9L6SvU4olel2wJ+WMnfSAuoOpyVeaMwef+2NeQXy
 SSTfMRbXK4DQunAnuJcDQhk=
X-Google-Smtp-Source: AGHT+IGUntfSy59J4jFuOOAYvocNAXQeViq+3qG2MciIER1uzhLAafKj8et630wb4iQqaqfKUogWWg==
X-Received: by 2002:a17:906:7949:b0:9be:2be:e6f6 with SMTP id
 l9-20020a170906794900b009be02bee6f6mr2187507ejo.12.1697257276890; 
 Fri, 13 Oct 2023 21:21:16 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a17090655cf00b0099d45ed589csm406651ejp.125.2023.10.13.21.21.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 21:21:16 -0700 (PDT)
Message-ID: <6736fbdd-4ac6-fdc2-10aa-193b574ecb99@gmail.com>
Date: Sat, 14 Oct 2023 06:21:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3] rockchip: configs: sandbox: enable rkmtd command
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 u-boot@lists.denx.de
References: <9fffc997-fd13-eba2-3a73-a8e86816667c@gmail.com>
Content-Language: en-US
In-Reply-To: <9fffc997-fd13-eba2-3a73-a8e86816667c@gmail.com>
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

Enable rkmtd command for testing with sandbox_defconfig
and sandbox64_defconfig.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 configs/sandbox64_defconfig | 1 +
 configs/sandbox_defconfig   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 1a033b22018b..1a01f51a0b75 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -58,6 +58,7 @@ CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_TEMPERATURE=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_RKMTD=y
 CONFIG_CMD_WDT=y
 CONFIG_CMD_WRITE=y
 CONFIG_CMD_CAT=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 01830c7bd255..cc54e6dec5af 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -84,6 +84,7 @@ CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_TEMPERATURE=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_RKMTD=y
 CONFIG_CMD_WDT=y
 CONFIG_CMD_WRITE=y
 CONFIG_CMD_AXI=y
--
2.39.2

