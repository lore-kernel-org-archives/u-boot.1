Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE52EC4706F
	for <u-boot@archiver.kernel.org>; Sat, 23 Dec 2023 00:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AD5F87579;
	Sat, 23 Dec 2023 01:44:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Jq2ZN6it";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D16F8772E; Sat, 23 Dec 2023 01:44:51 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 291F68753D
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 01:44:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703292287; x=1703897087; i=xypron.glpk@gmx.de;
 bh=5gko8YhLDnHiZj2VIXDQFGXfSNsSo0H4Zn6w8AiXDkE=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
 References;
 b=Jq2ZN6itd2xPRlbDuWL+ASAwSB8E87UE9gQgWh4ev7e1KqNeaNNy8PoCFYYCQDve
 +WZCIG/FB/Rvq4F3j0cXVIvpFmc70ihI3FYo4+S5CwZE6mKu9SzAAvCHgSnncZh3P
 UU1vtEKPz4mGyEDmBesP3V+rDamEWeVQpsSR/PRnYkE6a44YTG4Ra2hkfl/4Cf0kd
 wpaBWEINjIxpQ+r8rgc8g9u4/yTqHhmChL2dUr2s42f0RSrEFoK5yq6/BABVv18qE
 WfbuOe1Yid0G0n2DWMNkH55xIbUlYH3hcDnyU8nvcrevvrI6lIFbrzDUAGBwNaVMe
 L5BVG860GfNDBkJhSQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from x13s.fritz.box ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbivM-1qiJrE3QHW-00dIkm; Sat, 23
 Dec 2023 01:44:46 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 2/5] smbios: type2: contained object handles
Date: Sat, 23 Dec 2023 01:44:26 +0100
Message-ID: <20231223004429.247301-3-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231223004429.247301-1-xypron.glpk@gmx.de>
References: <20231223004429.247301-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JFjuCNQx00t1MunG95DWZhloJTCTRn/CBeiKYeNCwJHDEpuoR/U
 a1KVO4BN5yMO8EL04PurfL2ahY6VJ4oaXYTj3ydt5YMOaJU3hs6vL+qp6MQYoQv4+WrtTRd
 D+OgB/WXE5QtRE2uHWhwnIxdpgYmk+7W55z/CPkIyLNuZ9v8cZMbHKQpPfPNPWGmdORyjnL
 3FTae+eC88aVon9IPhTPQ==
UI-OutboundReport: notjunk:1;M01:P0:Is8ERwoFrtM=;+ttOVOOY0NtoJLO1O1msvVdNkTq
 phjg4HHror1ZE3WJuk6iTXoe3CDB1anIHLCrBgsnXfpeH73gS8r52WeE0M9zdb9SyUHrkmict
 DG24PNSmhKf7vPZni3Gn/fgFJ4vWWnRP7uOnbkjSKLyn/tAmH0zxqTU8xX2CTXTUjfErDTHSN
 mTLIdJrDNFElkGCnL3Q7FOLTYPgKdp/G44e9OeQiFSFAO5YlkJ6g37WRCsQ9NL0yPbpb4sY4Y
 1RfZpR6dVmciU1/43DjTrMtlQZjSfv+OcVtasNGxOaIVr7ZGtfJQWIYIwY8jMwORPp5rxdN2E
 Va8J1ageFuiriVhNbQz0bkhTXg6Pm5q+ZyXV4UR/goOc2SyUa7NbCIVr6l2Z526s0UEsEnW+P
 gHCqSJwArHIWiIKuGci5xTG2kIrxegwBgFTdYmAY0e/w9Rbi93IzUycdOS10o3uU3+yxPp6El
 6BpY4OZc/tvgsf5oKMMVpSCPbcaL6zojwtKej0IEzEKhIQTZzrCCMN+5EY2LjUa7ktTztJALI
 8lDfu3Vp0IRV33IejSavd3GIY+ZCRGElIaxNBNcRMLixWFD7MyFgUXIuTkBx4ggND62GUj8oa
 yB50N9XLRZCDMaC57/hTZJZ+Lpi2V4eJHMHFavunu44iOwUnPOeIv7V8jxEbwUDdifspf/ja1
 ibBaJDZVwRrNUeB3IKTLPzJT19weEtI+jbYDlETVGA6NueZfd2QQA141vooEonCaAOV8Tg6Nc
 WQcyxZSLz1jteDDFqXVGUJ6jq/VkU9AGCA+M8HDGFud70xtOMlZ3EMXXeuZoynXfdQXqdyZlQ
 S6ghFMEPJ4lkFridImZ01LF209MBj5gXV8XDDyANo+kZCxN4HL45BSCWiyTmFTHhg1RBHDPM3
 eJLebNFPPX5uS6P7Juu7jNz+sbLRIZ1Fm72+eMYfh1Mp6wg1urboTEGk9cz6nI4o1L3nME9h7
 7008n9Y8XgyMI5/jVkX1vtsCAs8=
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

The type 2 structure must include information about the contained objects.
It is fine to set the number of contained object handles to 0.

Add the missing field.

Fixes: 721e992a8af5 ("x86: Add SMBIOS table support")
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 include/smbios.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/smbios.h b/include/smbios.h
index e601283d29..88c19ae062 100644
=2D-- a/include/smbios.h
+++ b/include/smbios.h
@@ -139,6 +139,7 @@ struct __packed smbios_type2 {
 	u8 chassis_location;
 	u16 chassis_handle;
 	u8 board_type;
+	u8 number_contained_objects;
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };

=2D-
2.43.0

