Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAE6CA6015
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 21:56:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE8C781323;
	Thu,  8 Oct 2026 21:56:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gw6L1J3SZnA5; Thu,  8 Oct 2026 21:56:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 997F981324
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791496587;
	b=GF2hOpHX76a3LQbC2A/4eg7tUnUlN2r4icPv/UwKpLgQs/emNM7OCSiJBueo8gecMeLw
	 w1VTMtQq/2de8WZ+xpge9K6WQ1A1M4rQJhAVw8vYRvXOO6NcxQrEFONdTRePf9pNuWhFS
	 sALygb8Rkauv2HfpKWkG4ED0QACHz9OsRsDeTnrBOUYARIREGO5B0WNWQdfKcWQlnuulk
	 8bqzBzAnPAXUekNCb81+4WeKztRH6GhZ4bs3425/SLClbYqwax5vzcZVK0SAXxcAHcv4E
	 YtNsgiC9oYzRsOGz2VtAM5M5vvt6uxv8T6YC+rnrFHpGmyCdmrj1NYqQBNhNhGLldsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791496587;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kmV661dkt8B3AC2urDkgrrRXS73BUxv7WW4oBN8MX60=;
	b=qC0jNsk+1kKsmBcQ1vNQdl0KC+TUHNDzgOesFlwQx+I2i4XRdgdqXqZKC/zLsPXoK+8X
	 XoJguerM1emU5PMRwcye8M2MmFsJ42rMMqZsQ/U5QKCWHHfd8y9Pc4RyfKec1nRenKaQV
	 9sRwAcfrvu6La37OrWaU5cAVocrWC7ryoPHVtSXBfMX5Rmm84mBUG1Ca4dVhuWmVr080n
	 opywFFEiklwFUuBJakQNSD0wz1FqfsqGr5s71jMP2XW79sfFe9ckoFaxiNF6d/nGW0Joi
	 RMNI0h6xm8CJ8rDQP/i6ncLxXCP8e77hAkMMJK+HgezsG+Vt6h9ij94Va0aB5eCOgMw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791496587;
	bh=kmV661dkt8B3AC2urDkgrrRXS73BUxv7WW4oBN8MX60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tGjEpkeushKW641yOD5vF+6/+zstKhXrMVnZQHkBKqn3GfT4dkr23oixCN3WCpPLQ
	 VjgUk7ZGF6tYXeGJR442mgwJcq6SDqVbwMSARneRSoBPlVz26aVe5f/M8QzSAIkqh3
	 Z4wnby+2hEqpB9GFrIaUklqU7CDwwq9mTvlPEyIXrw9+tbk1v2gkWBTWe3Wpc23vtx
	 TlSZsXpWszMNx6pA1f/2g4UoGz8Z4tY9wqixP8UHZoUdj6v9REEFYGjDD3g1h1xC+d
	 BwkZJiZ0WrSJLpqLz+JWhK+uh06YgM7cbYl+D7Ovqmawj6numtrSgEnjOIZ7yRAziY
	 PxLc0pHCjSg9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 997F981324;
	Thu,  8 Oct 2026 21:56:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D2AB41A6
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 21:56:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B8CCE60832
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 21:56:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oN-OngbIGPA5 for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 21:56:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D62D26082C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.136.65.227
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791496586;
 b=sPkiGBs0CCsappL6hqQdK8hPIyAWngG9sMt6aIpJJl6XbnqW+AHIq1x7TvHZ9zP95UED
 IfUdL0DpJhaiALwDO9K+GO5CmJ5z/1gYezQpDeCI8tnCdnGhGUl506wYeK63FjQcZ8sH/
 BP3ItqJaAGJp77lBqthcwEfiEFUxesFfqaHvLhDJj0wYb1YaYVmbl2HaJ7ZNFMVqHZPPH
 mKCXmog0AZGiQcbWW1eU1MOYXU/YXWVx8iST3xC4flGRZqAVCDmXuzwxOBvb67Q1jMTAc
 3R55H72k9MBGiEnvqGRSJWzOsGQ6GOnJyi2T4ezqrDxkATdM52j6w5coyRkD63CSMqg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791496586;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=kmV661dkt8B3AC2urDkgrrRXS73BUxv7WW4oBN8MX60=;
 b=TRZT/pN+Rt/itPQgqS+HfXeFxHUGLjLTrSgR98du/rKfO6lnhPFrMEnT+VY8/IerbBYD
 OvEAsUQotOvDrRqSHOPR9mfCTqi4L9irflH2NtH9WOwwHH1WVoXeTOXEvvnRmfTjzdTbx
 WNbKFsuNZYQvNu7U7x+MEoCJTAOSSOQFcoZkuY45JrCokC4R59sK4YCW6z125lO3EnKR5
 48IVrBufTtLfos8Td1Zo3rrKjQAciwdWLkCioDhz9STciOzhNW2t1QajFasTthrPPxjjk
 6EGCDYn0CWsucUJdbGAadL+Y97XngUnQIPwV0AgpXcuB0raRJMMkS0N2KrskW2cVeoA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=SE+CIXWm; 
 arc=none smtp.remote-ip=185.136.65.227
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 08 Oct 2026 21:56:25 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=SE+CIXWm
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.65.227;
 helo=mta-65-227.siemens.flowmailer.net;
 envelope-from=fm-664519-20261008215520ed55261bff0002074b-4zqt_c@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D62D26082C
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 21:56:25 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 20261008215520ed55261bff0002074b
 for <u-boot@lists.u-boot-project.org>;
 Thu, 08 Oct 2026 23:55:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=kmV661dkt8B3AC2urDkgrrRXS73BUxv7WW4oBN8MX60=;
 b=SE+CIXWm6Rxi9C4Gbqsp++/I0bRFCxTWoxLu/A9mZGkKZMUjxJHTzKBz6ftyjpBqMorM3s
 Jg35V6fDe/u948JnkvIJ1PG9xMRpSiHfn6XeorqUF6cYnkhRW+2BNnVUjZGBIV1WlT/9DyTF
 j774mUzZfMlxGveMsiW6T2SfyBdqaj1+y3uy+5ywOaMv/9wczlN5usi+6GLifdkp5nPqq/x0
 6nY2vg0OzevmWLDnUn+UtDCzdtQnPoisHuJCQ2RssdiYnB5KDhS+qtDci7znElYYzJ5IRIaE
 0eI0+pBW6j83vgVEAYoGZiSaszNlaFo4+JvvmD0+duvsDv1J0TP6IoeA==;
From: Michael Haener <michael.haener@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v4 3/3] xilinx: Use CONFIG_TPM_AUTOSTART on Kria
Date: Thu,  8 Oct 2026 23:55:18 +0200
Message-Id: <20261008215518.209510-4-michael.haener@siemens.com>
In-Reply-To: <20261008215518.209510-1-michael.haener@siemens.com>
References: <20261006155217.187050-1-michael.haener@siemens.com>
 <20261008215518.209510-1-michael.haener@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer
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

The Kria boards start the TPM with a 'tpm autostart' call in the board
environment. Enable CONFIG_TPM_AUTOSTART instead and drop tpm_setup from
the environment, so the TPM is started even when the preboot script is
changed or skipped.

The TPM is now started before preboot, so the TPM reset hints for some
carrier card revisions are printed after the startup. Boards which still
have the old environment saved run 'tpm autostart' a second time, which
is harmless.

Signed-off-by: Michael Haener <michael.haener@siemens.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v4:
- Add Reviewed-by from Ilias

Changes in v3:
- New patch

 board/xilinx/zynqmp/zynqmp_kria.env  | 4 +---
 configs/xilinx_zynqmp_kria_defconfig | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
index 89f48c03586..ed6c1d7ad6f 100644
--- a/board/xilinx/zynqmp/zynqmp_kria.env
+++ b/board/xilinx/zynqmp/zynqmp_kria.env
@@ -66,7 +66,6 @@ bootmenu_delay=5
 # Enabling PM nodes for uart0 and can0
 kd240_setup=zynqmp pmufw node 33; zynqmp pmufw node 47
 
-tpm_setup=tpm autostart;
 tpm_reset=echo "!!! For TPM reset a full power cycle or pressing the POR_B button is required !!!";
 tpm_kv260=if test ${card1_rev} = A -o ${card1_rev} = B -o ${card1_rev} = Y -o ${card1_rev} = Z -o ${card1_rev} = 1; then run tpm_reset; fi
 tpm_kd240=if test ${card1_rev} = A; then run tpm_reset; fi
@@ -76,5 +75,4 @@ rtc dev 0; \
 zynqmp mmio_write 0xFFCA0010 0xfff 0; \
 if test ${card1_name} = SCK-KV-G; then run tpm_kv260; fi;\
 if test ${card1_name} = SCK-KR-G; then run tpm_reset; fi;\
-if test ${card1_name} = SCK-KD-G; then run kd240_setup; run tpm_kd240; fi;\
-run tpm_setup
+if test ${card1_name} = SCK-KD-G; then run kd240_setup; run tpm_kd240; fi
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 2eb4fe4e8bf..2f9d6ccf98f 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -222,5 +222,6 @@ CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman-som.dtb"
 CONFIG_PANIC_HANG=y
 CONFIG_MBEDTLS_LIB=y
 CONFIG_TPM=y
+CONFIG_TPM_AUTOSTART=y
 CONFIG_SPL_GZIP=y
 CONFIG_TOOLS_MKFWUMDATA=y
-- 
2.55.0

