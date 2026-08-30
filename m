Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D2DC61DB9
	for <u-boot@archiver.kernel.org>; Sun, 30 Aug 2026 08:44:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36BB360627;
	Sun, 30 Aug 2026 08:44:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FMUaeyz8BZ92; Sun, 30 Aug 2026 08:44:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788079450;
	bh=UUQfz3NoDwa5sjM+zFj8wgqPxcAx2zOkBK3J6tSPToI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=osqjw/pC9D2Pmb6w9bsAxVbNgKYfBoN3u5KK9qCdbyj1XxrCG5KM9s2lLr+58uLzD
	 ayEYtHeuZ91GRErlCv71XzggbDc9nd2QFfnFS0qgaotS/6A6pMoiSjC9XoIeaF6nIi
	 ETRuZ3Ntf47Euvot2kZ1pPojj7meLhAd8QxkG2zkAjVGt0hUQUwwKtoKOfI4zvgVrX
	 qw0FUN7k6Vx4JhpZet4F2PmncyD5NAnQ/Leytu56KTrlNQm3S6y/HH1TD+a5Sfsx8v
	 phK3focuHz6lh0lANGiOyiVpBWahsoWE0QnMtIebxyQbLwhCKcZhtQzZaUIvMLT7eH
	 DIlclOO3m+W8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C259605D6;
	Sun, 30 Aug 2026 08:44:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3BA44334
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 08:44:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2AF0440632
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 08:44:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P_jU-hhmYsOR for <u-boot@lists.u-boot-project.org>;
 Sun, 30 Aug 2026 08:44:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=bVpiojHi
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0E89F40631
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 08:44:07 +0000 (UTC)
Received: from LT03.fritz.box (ip-084-119-040-110.um24.pools.vodafone-ip.de
 [84.119.40.110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id EA9523F19B; 
 Sun, 30 Aug 2026 08:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1788079445;
 bh=UUQfz3NoDwa5sjM+zFj8wgqPxcAx2zOkBK3J6tSPToI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=bVpiojHi7PcdcJ6sM+ERDRWitRJgFujdJRDNNWoXR7KADr8fgKGWHMh2+UjCBPCGB
 njz6kHlKvweMwrizQrro75f71P5q4gHa+RGq1LEVYlBjKICRuCMul7wXsK97tXaAHZ
 +GgaCLUxXrjTeAxxPaRzPkVX+jgoM+YfSRac3xEASdACeqNb3lGV3BndgNpibiA5o0
 f34QcBdszQamsiapIq4sDk0aq0nUxYviI4SMXhSEJTUQhxdtJBrH4U6jUSU5Khn78a
 q4ZL8sNhnICI4t9PXj24VqRIa2VxS/hfiDiHdUSRYqsbWFWBymVs7GdBWbYaH+968g
 OUDuti+6U9hAAjmPe0Uug8akHB7zHCsidVV/AQaoLS8GJRynh4yKAfRK0QyyoNaiB4
 DFl+l4CpVWzJylXhncG3LJCL0qF5RspLajeL+dWn09Fg6LOLaSDCyEnof+ZdpBt1+H
 JjcpqIgqBdcHeDthqUa/ogcKjzjYJ+tvOBeRb1idIemq6YphgwTbc6wBWvHmSw/aTT
 2CYgeOLDsSKyNI9ge3TGuoSMD/1LKaXDoLkugAdvJGpwfHKqnbA0MRsI7/7/XAAAS7
 Mnjak1WlXUL4m4dv+JqmhNCfcCpkey5XXkk6zxyCJ2l11Lh4uzYzSvpfcL2funTtY5
 FFkBaaT+zrcd8EWGjIe4758E=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Denis Mukhin <dmukhin@ford.com>,
 u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/2] efi_loader: consider type of platform_get_rng_device()
 return value
Date: Sun, 30 Aug 2026 10:43:58 +0200
Message-ID: <20260830084400.250238-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The return value of platform_get_rng_device() is efi_status_t.
It does not fit into an integer variable ret. Use variable status.

The RNG device was available when registering the protocol. When it is no
longer available in GetRng(), this is a device error and not an unsupported
algorithm. Use EFI_DEVICE_ERROR returned by platform_get_rng_device() as
return value of GetRng().

Remove a duplicate debug() message in platform_get_rng_device().

v2:
	* remove debug in platform_get_rng_device()
	* keep the debug messagen in get_rng()

Heinrich Schuchardt (2):
  efi_loader: remove debug in platform_get_rng_device
  efi_loader: consider type of platform_get_rng_device() return value

 lib/efi_loader/efi_rng.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

-- 
2.53.0

