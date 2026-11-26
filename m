Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F1B606A339
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=m0EiUEu+;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Os0Budp1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C652D81181;
	Thu, 26 Nov 2026 13:33:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1pQZdR4olcpB; Thu, 26 Nov 2026 13:33:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C112E8119D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700017;
	b=aTh0jU/8GgbWchjisMwDDg+9mL1m8yadv7+I7TECEs/WiAo8zScE0gY2E37NgzinwitR
	 9cH8/DhM8K0DzjKRTayHprhxMHgXBRTK9Zf3fsV2ufY/2t0U6yUrv+JM+wb02urxvEWWN
	 2I7bGcsc12IvxIssD0KMLSIgB7aechedcrs8tSy9RHy75b3vxD27mGMO3IScp2TxreqxR
	 QlqQNfzs/nPP7cUlfCtR1ZCMkni3VvULhZrXqlF7CO29ypnNI+vqmgmDp/Yq4s9843W2A
	 DhnYOn2e2YOS5pVCOuW/Z0Ui2bOU+2jEWfyQ7EJnRLD/eK7RP4vF23dJ32EFcWVnhcg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700017;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6fsYMR8SeV0flYtsIylVBasEQ7RomJB+HqpPYsg1QFs=;
	b=fpd7/iJ7X2sOUWJSO764LFJkpylGrZ1U5Lqbw7+LKTUC5YG8Wis+3p/2gZ771BALvfOM
	 urlupDRuAWN6VH03eOxQ7X3GJz+qBQAVI4jbNi/j7ZEZve3Tq1U+JM3yT9sxksdSnV+Lx
	 vXEZ9r/N9pqBuRCNdmQp9qNgvYpVjpMmBGJ4GLpiOezB1f6V3uaUR2Fr9/Moe9jyxtLqC
	 piOPGPHYSkak8GiF3Jzhyp2eqJ2YxCiAEgT0Zk3krPY9sYVIHsVbNG/vtVYCaNN88R9zF
	 5lNGx+/W9ajOtX6/9H3DCs3wrRME2LwmjeyB4OJrE2E0D28Rnt16thuQxR99tlJhFuQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700017;
	bh=6fsYMR8SeV0flYtsIylVBasEQ7RomJB+HqpPYsg1QFs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m0EiUEu+9TJrMjbnZh2RRgwI8NU2brM3tPbf4wEswZDdOmmnQZgleiDwSnz32VLn6
	 QvgYG+n0RDQj/BhkXuCriEAcu4mpFEOCnPstyaddaXcBc2Ym71I9KhIaEFSmw93V02
	 doNWr974R6WiESyt5Ad/OcFW/MoMvx4+j9l7+ySAgpdK7yA6VGrbjAHykXgDLHek4d
	 TUqlmNzkCuFk1rdr+AlGDoxvJ2ktT6o/r8QrJTtrrb0NX98+cfx7i6d5lSUxI+Y6PC
	 pVCsn6t9p+lQ+ZqeDdJYakRiC2NAb1IyQHRlDPPquKQ2610MCaXK2pMzOvOJleTQvz
	 6QRn4QacQEvjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C112E8119D;
	Thu, 26 Nov 2026 13:33:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D3B74260
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BAC1940492
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZLhcat6FbavT for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 06:53:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C6C9C40490
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Os0Budp1
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C6C9C40490
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:28 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6df5e315bd1so5393774eaf.2
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795676007; x=1796280807;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6fsYMR8SeV0flYtsIylVBasEQ7RomJB+HqpPYsg1QFs=;
 b=Os0Budp1VDIM6DFg2Y5yUiE2ImIbth3iIhMN1DfZ0F7luZjj6Bj6ulWixDsD8Subwp
 W7c+izpFVOCVk17EXIDeBZitrRmpBwFUYGoB0pARGYdgLyZf3FXRypwkTdJamtFmec5Z
 DD39aQz0aFaLk63HSo4GqJ0eu4q2B/Gkx9j+8YpCd8tyE437L3r6ar0zXtNPkFnnOHiL
 e2dniEd9Zk2Kk+ibpIvwLToTLGdc5rqGQUT8ty7wO8ym3thz6esY1bK576YtIHbde6VL
 wOCtlDL8rew/P4iDfXQnqZkjw5RBB0ikLdCLJuDmdS9qFa9U3qYu6VPrwLO+31OsYp/T
 OeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795676007; x=1796280807;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6fsYMR8SeV0flYtsIylVBasEQ7RomJB+HqpPYsg1QFs=;
 b=GpLcAaU4B/VCMKb1CI+Y8Q8Vzt/xBTjNaLvs6N9Mh3WjusuZlqK473tRg6zmcTE0hM
 wgjvMdZvQmmp003BIuBQRzFnlbKf5D1lWrsK3pjG4KORxl+rKweCHuMZf/rwjyObkuQl
 KaXtvEuf02romIHOn3FP6ido8B3rqEEATFMFXEYRU7F2RXIVkXs10Zsukz+Afus9TWkv
 D9IwxvUJ3AuuSQxLVUC298PaMQ1I3xlwlIZ0riPyinZsHwed59sf4iUyIfNa8y81FHsv
 tqACukhD/VwVleq8eVasAjLQjcerK3bwP/ePxQQhy2s2bfC5f5SpT0sd51zOxaHby+ek
 2sHg==
X-Gm-Message-State: APuU4Z9n+NgNf0x9TuF6peHFpxon+tYkXrZUkAqhka+5VmFKoBJAXpDD
 xXW9ZDppKp3tjq11uJxpPNi6MDMht8YjJjVTAzX+nHAixsFlilq5u1K3
X-Gm-Gg: AZFdTZdGNvDJ9PN64/YLBIkBm5UbuCrpEdS4FqZjZpPbNUEtjJtJepy1czmZFR1w83d
 3pdQeoGSz1wdUfQfOksKq8jcxfid4Vo0LYzPMz2/43tMGLyOmH2IVGadzJyHi+NZlO+hlPpRBSs
 b8y6Snnm+WQjaou95q5klKPGrYHoDsMjFmZsEnCXTwsORoDP82T50XnV900zThu4k5Sf57+Yapq
 Qnk5t9n7AGmBPLpfdExg9DU6eC7KmNyyk6+vGuIQykV9nhgNEdt88KjkE6zIoa2QWV86kba45zP
 yMz1loUtHFHfbaGJpIcPC1aKSNpIxfhX+EwlmQ0wbxMx7rUK7OahZ6/6fuqwr+ZPldwvCA8aUse
 Pxs5N9rKbaCSRGBl0I7SS1Yfv5hT1EOQiv9l8v8xiD3HabYs0EeQkquP5fK35d7N5H7mADCamZE
 t7i3/L132cR1LMN+ToQ0X6Oa3xc6r9d17b8ubuHqGlMBioxlM/G8mF5TToh8ZBWISZ2F1PYTeqj
 ljI9kkx7m5z8rWN5gE0K4jn8av4En0FNZsb6ZOmz2Djg53o+Bx6wbWCKlvX/Rfo7nK6LtH5nI4Z
 84uYVd8wuCCFWE9jm2Wrp0q49vcJ6UMek7tkTlDwc0+3XuTB0uSUnPx/JmfBYGwrJUKlOniTN9/
 tYobo04f7OQ1RGOPIKJaXh/tFn0kc5lL+5C7i8r8ICFDCz/EJAxW+lYBEgudkXQYVlTliow4A8+
 fPeImmRP4p4fP8gvm3PfSOyUyTxF09zuLu5gQe+UTwKCwINxjkALuHPbtbTuSp1liRkhlFeYb2
X-Received: by 2002:a05:6820:4204:b0:715:21d1:b70 with SMTP id
 006d021491bc7-71b392944b3mr14480446eaf.4.1795676007406; 
 Wed, 25 Nov 2026 22:53:27 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86385358ca2sm31041a34.21.2026.11.25.22.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:53:27 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 25 Nov 2026 23:52:59 -0700
Subject: [PATCH 10/19] net: lwip: restart NFS after an RPC timeout
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-submit-lwip-network-boot-v1-v1-10-63df291d9392@gmail.com>
References: <20261125-submit-lwip-network-boot-v1-v1-0-63df291d9392@gmail.com>
In-Reply-To: <20261125-submit-lwip-network-boot-v1-v1-0-63df291d9392@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Piyush Paliwal <piyushthepal@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Michael Srba <Michael.Srba@seznam.cz>, Peng Fan <peng.fan@nxp.com>, 
 Carlo Caione <ccaione@baylibre.com>, Daniel Golle <daniel@makrotopia.org>, 
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alessandro Rubini <rubini@gnudd.com>, 
 Mingtian Li <limingtian@email.szu.edu.cn>, 
 Romain Gantois <romain.gantois@bootlin.com>, kongchen <3305708832@qq.com>, 
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Heiko Schocher <hs@nabladev.com>, 
 Francesco Valla <francesco@valla.it>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev
X-Mailman-Approved-At: Thu, 26 Nov 2026 13:33:17 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When an NFS server stops answering, lwIP exhausts the RPC retries and
returns to the prompt even if netretry allows trying another interface.
Restart the network only after this timeout, once the old UDP callback
has been removed. Re-resolve the server on the selected interface and
start a fresh transfer so the previous attempt cannot inflate its size.

A timeout can occur after the first attempt mounts the export. Reset
mount ownership at the start of each attempt so a mount failure on a
replacement interface does not send UMOUNTALL using stale state.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 net/lwip/nfs.c      | 32 ++++++++++++++------
 net/nfs-common.c    |  5 ++++
 net/nfs-common.h    |  1 +
 test/dm/lwip_ipv6.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 113 insertions(+), 9 deletions(-)

diff --git a/net/lwip/nfs.c b/net/lwip/nfs.c
index 3ecd259717a..1f6f84fd24f 100644
--- a/net/lwip/nfs.c
+++ b/net/lwip/nfs.c
@@ -117,9 +117,6 @@ static int nfs_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
 {
 	int ret;
 
-	ret = net_lwip_prepare_addr(net, &srvip);
-	if (ret)
-		return ret;
 	ip_addr_set(&sess_ctx.nfs_server, &srvip);
 	nfs_use_rpcbind = IP_IS_V6(&srvip);
 
@@ -150,6 +147,8 @@ static int nfs_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
 	image_load_addr = addr;
 
 	nfs_timeout_count = 0;
+	choosen_nfs_version = NFS_V3;
+	nfs_reset_mount_state();
 	nfs_state = STATE_PRCLOOKUP_PROG_MOUNT_REQ;
 
 	ret = nfs_udp_init(&sess_ctx);
@@ -173,8 +172,10 @@ static int nfs_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
 			break;
 		}
 
-		if (nfs_timeout_check())
+		if (nfs_timeout_check()) {
+			ret = -EAGAIN;
 			break;
+		}
 	} while (true);
 	debug("%s: Loop exit at %lu\n", __func__, get_timer(0));
 
@@ -189,7 +190,7 @@ static int nfs_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
 		if (env_set_hex("filesize", net_boot_file_size) ||
 		    env_set_hex("fileaddr", image_load_addr))
 			ret = -EIO;
-	} else {
+	} else if (!ret) {
 		debug("%s: NFS loop failed\n", __func__);
 		ret = -1;
 	}
@@ -308,10 +309,23 @@ int net_lwip_nfs_download(int argc, char *const argv[], const char *bootserver)
 		goto out;
 	}
 
-	if (net_lwip_resolve(&net, server_ip, &srvip,
-			     ipv6 ? IPADDR_TYPE_V6 : IPADDR_TYPE_ANY) ||
-	    nfs_loop(&net, laddr, fname, srvip) < 0)
-		ret = CMD_RET_FAILURE;
+	net_try_count = 1;
+	net_restart_wrap = 0;
+	do {
+		ret = net_lwip_resolve(&net, server_ip, &srvip,
+				       ipv6 ? IPADDR_TYPE_V6 : IPADDR_TYPE_ANY);
+		if (ret)
+			break;
+		ret = net_lwip_prepare_addr(&net, &srvip);
+		if (ret)
+			break;
+		ret = nfs_loop(&net, laddr, fname, srvip);
+		if (ret != -EAGAIN)
+			break;
+		puts("\nRetry count exceeded; starting again\n");
+		ret = net_lwip_restart(&net);
+	} while (!ret);
+	ret = ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
 out:
 	net_lwip_stop(&net);
 	free(arg_copy);
diff --git a/net/nfs-common.c b/net/nfs-common.c
index a82b3b795a0..06216cc3bcc 100644
--- a/net/nfs-common.c
+++ b/net/nfs-common.c
@@ -72,6 +72,11 @@ const ulong nfs_timeout = CONFIG_NFS_TIMEOUT;
 
 enum nfs_version choosen_nfs_version = NFS_V3;
 
+void nfs_reset_mount_state(void)
+{
+	fs_mounted = 0;
+}
+
 static inline int store_block(uchar *src, unsigned int offset, unsigned int len)
 {
 	ulong newsize = offset + len;
diff --git a/net/nfs-common.h b/net/nfs-common.h
index b48e035c6a8..b61ba833eea 100644
--- a/net/nfs-common.h
+++ b/net/nfs-common.h
@@ -111,6 +111,7 @@ void rpc_req_common(int rpc_prog, int rpc_proc, uint32_t *data, int datalen,
 		    uchar *txbuff, int *pktlen, int *sport);
 void nfs_send(void);
 void nfs_pkt_recv(uchar *pkt, unsigned int len);
+void nfs_reset_mount_state(void);
 
 extern enum nfs_version choosen_nfs_version;
 
diff --git a/test/dm/lwip_ipv6.c b/test/dm/lwip_ipv6.c
index 5eb48adb92c..871f0446590 100644
--- a/test/dm/lwip_ipv6.c
+++ b/test/dm/lwip_ipv6.c
@@ -82,6 +82,7 @@ struct ip6_test {
 	unsigned int dhcp_bad;
 	unsigned int http_requests;
 	unsigned int rpc_requests;
+	unsigned int unexpected_umount;
 	unsigned int sntp_requests;
 	unsigned int console_packets;
 	bool console_no_reply;
@@ -106,6 +107,9 @@ struct ip6_test {
 	bool cancel;
 	bool fragment;
 	bool empty_nfs;
+	bool drop_first_nfs;
+	bool fail_retry_mount;
+	bool retry_seen;
 };
 
 static u16 ip6_test_checksum(struct ip6_hdr *ip, void *data, unsigned int len)
@@ -662,6 +666,26 @@ static int ip6_test_rpc_reply(struct udevice *dev, struct ip6_hdr *ip)
 	const char *uaddr;
 	int ret;
 
+	if (test->drop_first_nfs && net_try_count == 1) {
+		timer_test_add_offset(1000000);
+		return 0;
+	}
+	if (test->fail_retry_mount) {
+		/* Complete the first mount and lookup, then lose READ replies. */
+		if (net_try_count == 1 && ntohs(udp->dest) == 4001 &&
+		    get_unaligned_be32(query + 20) == 6) {
+			timer_test_add_offset(1000000);
+			return 0;
+		}
+		if (net_try_count == 2 && !test->retry_seen) {
+			/* Restart the reply sequence on the replacement interface. */
+			test->retry_seen = true;
+			test->rpc_requests = 0;
+		}
+		if (net_try_count == 2 && ntohs(udp->dest) == 4000 &&
+		    get_unaligned_be32(query + 20) == 4)
+			test->unexpected_umount++;
+	}
 	/* A normal NFS export requires a reserved client port. */
 	if (ntohs(udp->src) >= 1024)
 		return -EACCES;
@@ -687,6 +711,9 @@ static int ip6_test_rpc_reply(struct udevice *dev, struct ip6_hdr *ip)
 	case 3:
 	case 4:
 		reply[7] = htonl(32);
+		if (test->fail_retry_mount && net_try_count == 2 &&
+		    test->rpc_requests == 3)
+			reply[6] = htonl(13);
 		break;
 	case 5:
 		if (test->empty_nfs)
@@ -1421,6 +1448,63 @@ static int dm_test_lwip_ip6_dns(struct unit_test_state *uts)
 DM_TEST(dm_test_lwip_ip6_dns, UTF_SCAN_FDT);
 #endif
 
+#if CONFIG_IS_ENABLED(CMD_NFS)
+static int ip6_test_nfs_retry(struct unit_test_state *uts, struct ip6_test *test)
+{
+	int ret;
+
+	test->drop_first_nfs = true;
+	ut_assertok(env_set("netretry", "once"));
+	ut_assertok(env_set("ethrotate", "yes"));
+	sandbox_eth_set_priv(1, test);
+	sandbox_eth_set_tx_handler(1, ip6_test_tx);
+	ret = run_command("nfs 2100000 [fe80::2]:/ipv6.bin", 0);
+	sandbox_eth_set_tx_handler(1, NULL);
+	sandbox_eth_set_priv(1, NULL);
+	ut_assertok(ret);
+	ut_asserteq_str("eth@10003000", env_get("ethact"));
+	ut_asserteq(2, net_try_count);
+	ut_asserteq(7, test->rpc_requests);
+	ut_asserteq(9, net_boot_file_size);
+	return 0;
+}
+
+static int dm_test_lwip_ip6_nfs_retry(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_nfs_retry);
+}
+
+DM_TEST(dm_test_lwip_ip6_nfs_retry, UTF_SCAN_FDT);
+
+static int ip6_test_nfs_mounted_retry(struct unit_test_state *uts,
+				      struct ip6_test *test)
+{
+	int ret;
+
+	test->fail_retry_mount = true;
+	ut_assertok(env_set("netretry", "once"));
+	ut_assertok(env_set("ethrotate", "yes"));
+	sandbox_eth_set_priv(1, test);
+	sandbox_eth_set_tx_handler(1, ip6_test_tx);
+	ret = run_command("nfs 2100000 [fe80::2]:/ipv6.bin", 0);
+	sandbox_eth_set_tx_handler(1, NULL);
+	sandbox_eth_set_priv(1, NULL);
+	ut_asserteq(CMD_RET_FAILURE, ret);
+	ut_asserteq(2, net_try_count);
+	ut_assert(test->retry_seen);
+	ut_asserteq(3, test->rpc_requests);
+	ut_asserteq(0, test->unexpected_umount);
+	return 0;
+}
+
+static int dm_test_lwip_ip6_nfs_mounted_retry(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_nfs_mounted_retry);
+}
+
+DM_TEST(dm_test_lwip_ip6_nfs_mounted_retry, UTF_SCAN_FDT);
+#endif
+
 static int ip6_test_apps(struct unit_test_state *uts, struct ip6_test *test)
 {
 	void *data = map_sysmem(0x2100000, 9);

-- 
2.53.0

