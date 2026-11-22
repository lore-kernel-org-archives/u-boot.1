Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0E1606A31A
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 23:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0PvrPcrp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=pl1OPvif;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=ap8HwxVN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71DC2405BB;
	Sun, 22 Nov 2026 23:54:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JBVElmR8sz4c; Sun, 22 Nov 2026 23:54:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5EC7E40611
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795391673;
	b=RHj8lz+hDE2rasvqDO+cYma++tUWgFpX+3kv3nL5XhgRZwOQxAzYAqUPCfc38lRkMCJi
	 C0gJJ78DOg0IsboEuAoBiJpZ/mJ/pzPU89suPJZU6T4hTwk/kvu3Gpp6ccQb0woXHFfuG
	 Zv83CGD5GrYC1HVOdqjyuN/WFJRYGJdElNMOlPAFsfclRt12U4aEBxYSuG5RlgW3eH+tR
	 vkZ24t/lT7vNeyrg9XjnN1+n3ahiV4Cc/J8oTE9a0dJZbZo/p1CPRq4M47WT2/P3XFNNc
	 FKfMbnuWdC646w8AA9SN/AZja05VgxPkWJv84ZAFF1dMUKfSmi/l58cfo/Pam5TduoA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795391673;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-Source:X-Source-Args:X-Source-Dir:X-SGantispam-id:
	 X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:AntiSpam-DLSRS:AntiSpam-TS:
	 CFBL-Address:CFBL-Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JflXhJCl4R0GqvnuOGd3Hpkhzcs+rEuLAa1OzSs09DQ=;
	b=sS5vvl0B5++yajftAS0PjezZ9EAxqMWKoU0Y0Cpjddo+pbQ9ahzG8D36llu8dsu04hOD
	 PGiRGcSBc3K0maVctKWypCsMHUbNmPAPcCTaZKxPLNbgdAn3eQcCr2HhP5Okxioboa98W
	 j26ydVtAH5uKA21ydWmQ0RjMS0L0PaRtNrp6RVBW0CIr87X5W9wOG1UmcrsQUuoF0frRw
	 LHVs2fn1yNT1R5CrSAKhOyRirKCLbH1C3XlNTUsz0LS98TEfr7HKVkv8wjryadKdrDNeY
	 sm2loRVH4Ktbzmj3TyhviRSFXXThhX78+KvGIFQpOHBHwcEgkyVXIfWXVIlq5CFEpUA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795391673;
	bh=JflXhJCl4R0GqvnuOGd3Hpkhzcs+rEuLAa1OzSs09DQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0PvrPcrponc4pB0wSYt3pb4kidgKkYeumdzDRZiQ64/BMfxX7KbeKTdh2/xdJTSYW
	 lLvGxFM9UAWGpY5vvIFqifXA8sIgLYEZ2b8M4DEb6mpRsTnsMElYPsdzOM9kyFSVKc
	 ZTjvwuw+bz0R9T9USrEXgRidY7fMq/vlb9slkttJRrjVCUA1B5Cj3T4gTH7yNjxXKP
	 tJNC0MguzaJYTc/re+FRhtv90kxu4hO5LFNNj3laSX0fFgSVISdrlqMqunxuX8Luzf
	 s58ka8g4L2OlWCJJPLCh10Ar1GkhV0xRfZR6C3uhb0uIgMYmpYmEeVuQvBHqRKy3V1
	 AOWV/rOJnPAOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5EC7E40611;
	Sun, 22 Nov 2026 23:54:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C9CBB260
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 23:54:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BBD1F4006F
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 23:54:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JM12dh3ASoCs for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 23:54:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 632CB40081
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=185.56.87.13
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.56.87.13;
 helo=delivery.antispam.mailspamprotection.com;
 envelope-from=francesco@valla.it; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com
 header.i=@antispam.mailspamprotection.com header.a=rsa-sha256
 header.s=default header.b=pl1OPvif; 
 dkim=pass (1024-bit key,
 unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256
 header.s=default header.b=ap8HwxVN
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.13])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 632CB40081
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 23:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=JflXhJCl4R0GqvnuOGd3Hpkhzcs+rEuLAa1OzSs09DQ=; b=pl1OPvift6XYkrjMa+7X7IVsR/
 uAjF8t8p8VYFyAZACUIj39056u220snrztiwpea/REtf7GsJ7iOX19aXSuVqfo2fi+B1hR600KUq8
 ym9lxGItiPPSfZNMRLesTKqPInsw7wfcJlCuL8PD3wTdD8igmkOgyd077snPdStuyw8E=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-lgmz.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <francesco@valla.it>) id 1xVHNx-0000000AEQY-2CkF
 for u-boot@lists.u-boot-project.org; Sun, 22 Nov 2026 23:54:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=JflXhJCl4R0GqvnuOGd3Hpkhzcs+rEuLAa1OzSs09DQ=; b=ap8HwxVN/74ckoLB33MulqbNVw
 ACBUrVzkLV091C8d1JHukosjIqNjt1PBnMLVM4BvTeY+Grjn9ahJoNJcH7IdIG8w8B/iFWqBcNbpE
 z/e2QsCsnVAUvg0Dy1Bye2w2oLWtM4kHeWwoTldbkXrePYkoCzmo81NQgJDI9kZKy0fk=;
Received: from [79.28.115.6] (port=62562 helo=[192.168.178.175])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <francesco@valla.it>)
 id 1xVHNt-000000005H0-1Yuj; Sun, 22 Nov 2026 23:54:13 +0000
From: Francesco Valla <francesco@valla.it>
Date: Mon, 23 Nov 2026 00:54:08 +0100
Subject: [PATCH 5/6] doc: beagley-ai: document Ethernet boot
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-am67a-ethernet-boot-v1-5-94520ed74c90@valla.it>
References: <20261123-am67a-ethernet-boot-v1-0-94520ed74c90@valla.it>
In-Reply-To: <20261123-am67a-ethernet-boot-v1-0-94520ed74c90@valla.it>
To: Andrew Davis <afd@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Nishanth Menon <nm@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2561; i=francesco@valla.it;
 h=from:subject:message-id; bh=I09oK6aD9RO2Y/FB0itBAfYMaJR8PJvtfsPuE/12ecQ=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDNnMDYvcG8pL99lqhnMVSV6OVfsS8OJDlXjTwbV7L7j7T
 nr1V02zo5SFQYyLQVZMkSVk3Y17e+aaf0vbwPgIZg4rE8gQBi5OAZjI1VpGhkfSmaH/zG0EZnhx
 KSmfXFVQ3ukd7PXFsydS6frJqWUxfQz/yz6IdW/ed4VppdsV202V2Q27E5b/z9X/YdtU+a3LPGA
 HEwA=
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.u-boot-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 962530a81e0c18395f7843caad904a79
X-AntiAbuse: ID - 962530a81e0c18395f7843caad904a79
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xVHNx-0000000AEQY-2CkF-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-lgmz.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add documentation and example DHCP configuration for Ethernet boot on
the BeagleY-AI.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 doc/board/beagle/am67a_beagley_ai.rst | 58 +++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/doc/board/beagle/am67a_beagley_ai.rst b/doc/board/beagle/am67a_beagley_ai.rst
index 3d2fc4a31950..5384b91ce74b 100644
--- a/doc/board/beagle/am67a_beagley_ai.rst
+++ b/doc/board/beagle/am67a_beagley_ai.rst
@@ -157,6 +157,64 @@ card prior to physically removing from SD card reader.
   * `USB-SD-Mux <https://www.linux-automation.com/en/products/usb-sd-mux.html>`_
   * `SD-Wire <https://wiki.tizen.org/SDWire>`_
 
+Ethernet based boot
+-------------------
+
+If no SD card is inserted when the board is powered up, the ROM code tries to
+boot from Ethernet, using the Ethernet Port corresponding to CPSW3G's MAC
+Port 1.
+
+Binaries for the Ethernet boot shall be built using the following config files:
+
+.. code-block::
+
+  am67a_beagley_ai_r5_ethboot_defconfig
+  am67a_beagley_ai_a53_ethboot_defconfig
+
+The DHCP server on the host PC needs to be configured such that VCI strings map
+to the right file:
+
+* "TI K3 Bootp Boot" maps to the file `tiboot3.bin`
+* "AM67A U-Boot R5 SPL" maps to the file `tispl.bin`
+* "AM67A U-Boot A53 SPL" maps to the file `u-boot.img`
+
+The aforementioned files shall be served by a TFTP server.
+
+An example configuration for isc-dhcp-server running on a host PC follows; it is
+assumed that the Ethernet interface exposed by the host PC is `enp1s0f0` and
+has fixed IP address `192.168.0.1` and that the TFTP server lives on the same
+host.
+
+* `/etc/dhcp/dhcpd.conf`:
+
+.. code-block::
+
+  subnet 192.168.0.0 netmask 255.255.255.0
+  {
+    range dynamic-bootp 192.168.0.2 192.168.0.5;
+    if substring (option vendor-class-identifier, 0, 16) = "TI K3 Bootp Boot"
+    {
+      filename "tiboot3.bin";
+    } elsif substring (option vendor-class-identifier, 0, 19) = "AM67A U-Boot R5 SPL"
+    {
+      filename "tispl.bin";
+    } elsif substring (option vendor-class-identifier, 0, 20) = "AM67A U-Boot A53 SPL"
+    {
+      filename "u-boot.img";
+    }
+    default-lease-time 60000;
+    max-lease-time 720000;
+    next-server 192.168.0.1;
+  }
+
+* `/etc/default/isc-dhcp-server`:
+
+.. code-block::
+
+  DHCPDv4_CONF=/etc/dhcp/dhcpd.conf
+  INTERFACESv4="enp1s0f0"
+  INTERFACESv6=""
+
 LED patterns during boot
 ------------------------
 

-- 
2.56.1

