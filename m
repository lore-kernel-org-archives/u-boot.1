Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E7B606A339
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gcdCBYGw;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X4tLPONB
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCD6260A95;
	Thu, 26 Nov 2026 13:33:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1A7I1sQbWsEp; Thu, 26 Nov 2026 13:33:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3A63160A9A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700016;
	b=AM9cBx0Beh3Z4/jXS+Px3pGONA3qldmVrSIxIbfWiWZkcKbHVUvt8Dodo3Ja7ObGVNs7
	 F/jkr42iiWkHBI9O06/ABrBf634jN8XSb0q1P5sE+kkET3LKrKhnSEOu+/9kYtSOi1EAJ
	 1R5zY0wBsxoQzNTH7xyv3dkmqMBEgTM0t1tX3nAUPFKGoqZDVwUj5F5LOYTudtwkMWE6k
	 fs6xm1J564RTlZyw3v3RUVHcm3S88/tw3BmvzUZoDxrPoS4WQ2owhjZuh8brGUzCztqa2
	 TfqmtqBobEMECAo6xq+yl1x8HZ1apD+tJQYHB68oO4MaN0cMTaLLReHZuK103jFj8NQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700016;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=iVFF6+xv6Z9LDr+PPrWSadB0Y4tRvgK3eXYpHz4qsTk=;
	b=B8o7ZqIQWNk4au2MYp1nQ1two8xx3X4KIj4Lvl2E8/dfV8wKmwdgvIAR8D/j3UDTKopm
	 rVdSyATwQy+vML/BO0hJlrn1FD8rf5GrLtXMyruGsCEHOBcm3yzpM9YWd6vz7yToy31Ca
	 cXCMHTOzi0q+f2BXP9ARHvxL0maQDPj1ALgFbdyc7tK024Q/ZUvpbaDOTYX9uiLLh/9Uc
	 DQs4bSAoGaoAMZnf0F/Lo+vX6BOmND+jXK16pUwT+AVV1uxyGbXmOdcE3WSIlZa1yM0M1
	 To0IC/Ow/cgIUCUiGN4dKVneki/NY4pSF31IPa1g9dH21RNA/nRFE8AuH7SS8oQrlyg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700016;
	bh=iVFF6+xv6Z9LDr+PPrWSadB0Y4tRvgK3eXYpHz4qsTk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gcdCBYGwBBPdfmZAk7GBhgKA8+/gnwHdXsy5DvOHTyAkZnFNHUDHneqOa5eV4AjKd
	 jZ9y2n/+GL0/15Svff1wArUnQQRiYyyvRmKSeQYm0xkpuVYFOxnvbA/ydihZSa5ray
	 C+I96hWUstKpWpJADm5JuSxtHARWilJ7rzh044aADmL5RHHeTASinop4+Euag3ZCTB
	 klk6yiSIqpifhB/Wu8vkEO6BDLgFRtP4vrb/uQdD45VLyUgZOq/DcJGB/XQcKK73Ib
	 24uDpqdIyOLr25ph6GuKlyhBKZQp3F97FCfQfnVbt/xGVtWzL1g6TkCcFMlscUi07p
	 XWt7UV09IVoxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A63160A9A;
	Thu, 26 Nov 2026 13:33:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BAA31C9
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7DEB340492
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l355qcd8GNvo for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 06:53:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8FC2340490
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=X4tLPONB
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8FC2340490
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:26 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-847ac7ccd85so3813841a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795676006; x=1796280806;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iVFF6+xv6Z9LDr+PPrWSadB0Y4tRvgK3eXYpHz4qsTk=;
 b=X4tLPONBfdPyy1mOSOsXarpbHtfD19UtDf8L6dHiwXunx5Ky4OlknF0gA3h3t1Rpzw
 V133FucNN7kpfaommEmrqhcqV5tJDa2jt4EZ95S5Or3urDuTrU2xH/tMFOAIr1tBxUjq
 iOtmW0auFT6otfVtcKF7kMM1ZGEffw8vnUPBdFlQFlPfBKzMOY6cV5P4TCqTp7gfJBHT
 VXhf8HgXMC0dSRj0KPWv0C4SsxYwkZuOWxZV6iDHMwglVQkCQ6uJbrWwW9h7wBmJoxrB
 6ZxCZq/iQGKJ60Sv9x9XZfuR5JLzI+uwr6Ef7LxnTBgHKZ0O9nKBDjQpDMRPWditRR6v
 KAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795676006; x=1796280806;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iVFF6+xv6Z9LDr+PPrWSadB0Y4tRvgK3eXYpHz4qsTk=;
 b=WMxvNKcuTLL2QrZcd7Z/x9+nJZTnVjbAkoBVO6JyilwxDF/4OTdDS9ttFzxzxaUDia
 D2VsuwuoWx9Zw4uVGHk93rqwYTgnDb1r5AqKHXfrF71cDPJ2niRPzgyI+1/jhCFEAY3j
 1PkzCOJw+cqTTTAMtyNhGMgfHy2f1kiYVc0YhSmhBKreXeLwC7zkM8Y6TgD7enS1MM+7
 ICmrd7X2OaSfPMe3duuFmwqHgWN5Uis3wJPWs7ARpB26t1bJabR1qKc4XMf7adX4TS/+
 vQETT5yzA9RWWgV9PYG4X1GPL8TBAcmf2LRYYwe95ZP+rcbZQ48CI4uCKR2DVRLQ3IdS
 V2oA==
X-Gm-Message-State: APuU4Z/F3njUz5EA3qFoSBIt1LuRx9eE39Me9r2szT78XWxEnwpTS9YM
 CMBWnMzMFMi1S8srwoLd1ScNiylS/fxzGcmC3IdqRE+GlX/Zty8exMwy
X-Gm-Gg: AZFdTZdNR3wBR+CyAoYo9/u9CfPPzNHZbic14dcXHF8Uz99GbRPL491NER5IdJFQ6DK
 kQp08hv2jLMBTZzdT9pRGRKrFqfeLuNctVZ9qnIK8VTLSHCTBHwF3HPNmoYONgFhVg3gnmmCj67
 im3WMwszu5NQc9HZIycEeeiImoga7Z+BoIo2SArY7H50nh6W0lnkjLgolff0jn9pIjT+jk5j+ES
 FG8796fpzg5Cv0awjw771WPdcGRVdMu1/aMGRhAS08Fp4qaaArzOWX98+lamfF5PmN94FcADXqd
 9+cAdX/QsoMCHlWLdJ2LTrNXbvpqGHstv/Aiy5IvdjDvsrP+z6XjeizEWsF/13Rjkv/J29y1Y57
 Y6aXI/YOJI4l6x/QKrRibSb5ZTpQY1KDe8KwHOydQUZ7rln2/b+TQpuYczNvXRoTlpTqhZQnU+v
 Pbj7pP7BuS4XKmjJ03qnHoMwCLLYEk7nkxmkrKTCSt2B0hBXiFvlI4fJPG/a42f6Onzib5qRZTR
 OBdguqnw9mflGICK7E9GHgsf53o2rMlX9/fhbhm2QvuPUG6dElXq2CG6p+Y0KkUR4PrT9yLSWPE
 EEec2cjhCDNdL54vyJyf7cukqPr+BzdWlk+lCzd0XXcK2DNEFNFQZ3eReWgE7g6VFOhRlpHTxhA
 5mEKXXfLQDg3uI+QRrDF8LndFbRtIH6ElAQiBi94+0DixYx0GtIT2j7rEydsGQGPnxyNhOW0v1A
 nYFV860xNv1wESRLulsG5mqiH9r124u6EAzORGnlD0dYat1hQdwKNnTblGBFPsphAX0YolucL+
X-Received: by 2002:a05:6830:2b08:b0:862:a0ce:f554 with SMTP id
 46e09a7af769-863157c3eb9mr22077605a34.9.1795676005684; 
 Wed, 25 Nov 2026 22:53:25 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86385358ca2sm31041a34.21.2026.11.25.22.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:53:24 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 25 Nov 2026 23:52:58 -0700
Subject: [PATCH 09/19] net: lwip: honor autostart after an NFS download
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-submit-lwip-network-boot-v1-v1-9-63df291d9392@gmail.com>
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

With autostart enabled, the nfs command leaves a downloaded image in
memory instead of booting it. Use the common boot helper after releasing
the network and only for a successful, nonempty download. Publish the
size and address even for an empty file, so scripts cannot mistake an
earlier image for the latest download.

Use the current bootfile when no filename is supplied. Let DHCP pass its
boot server directly to the download operation; the initiating command
handles autostart.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 include/net-lwip.h  |  1 +
 net/lwip/dhcp.c     | 43 ++++++++++++-------------------------------
 net/lwip/nfs.c      | 28 ++++++++++++++++++++--------
 test/dm/lwip_ipv6.c | 29 ++++++++++++++++++++++++++++-
 4 files changed, 61 insertions(+), 40 deletions(-)

diff --git a/include/net-lwip.h b/include/net-lwip.h
index 2f66732fd85..8b64f32b913 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -118,6 +118,7 @@ bool wget_validate_uri(char *uri);
 int do_bootp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
+int net_lwip_nfs_download(int argc, char *const argv[], const char *bootserver);
 int do_tftpput(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_tftpsrv(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index 28c1064add8..b756199541b 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -930,28 +930,6 @@ out:
 	return ret;
 }
 
-static int dhcp_nfs_autoload(struct cmd_tbl *cmdtp, int flag, int argc,
-			     char *const argv[])
-{
-	const char *server = env_get("tftpserverip");
-	int ret;
-
-	/*
-	 * DHCP's siaddr is a boot server, not necessarily the address server
-	 * stored in serverip. Supply it only for this download, preserving an
-	 * explicit nfsserverip and the NFS command's filename-prefix priority.
-	 */
-	if (!server || env_get("nfsserverip"))
-		return do_nfs(cmdtp, flag, argc, argv);
-	if (env_set("nfsserverip", server))
-		return CMD_RET_FAILURE;
-	ret = do_nfs(cmdtp, flag, argc, argv);
-	if (env_set("nfsserverip", NULL))
-		return CMD_RET_FAILURE;
-
-	return ret;
-}
-
 static int bootp_run(struct cmd_tbl *cmdtp, int flag, int argc,
 		     char *const argv[], bool bootp)
 {
@@ -1078,16 +1056,19 @@ static int bootp_run(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	if (ret)
 		return CMD_RET_FAILURE;
-	if (downloaded)
-		return net_boot_file_size ? bootm_maybe_autostart(cmdtp, argv[0]) : 0;
-	autoload = env_get("autoload");
-	if (autoload && !strcmp(autoload, "NFS")) {
-		if (IS_ENABLED(CONFIG_CMD_NFS))
-			return dhcp_nfs_autoload(cmdtp, flag, argc, argv);
-		log_err("Cannot autoload with NFS: command is disabled\n");
-		return CMD_RET_FAILURE;
+	if (!downloaded) {
+		autoload = env_get("autoload");
+		if (!autoload || strcmp(autoload, "NFS"))
+			return CMD_RET_SUCCESS;
+		if (!IS_ENABLED(CONFIG_CMD_NFS)) {
+			log_err("Cannot autoload with NFS: command is disabled\n");
+			return CMD_RET_FAILURE;
+		}
+		ret = net_lwip_nfs_download(argc, argv, env_get("tftpserverip"));
+		if (ret)
+			return ret;
 	}
-	return CMD_RET_SUCCESS;
+	return net_boot_file_size ? bootm_maybe_autostart(cmdtp, argv[0]) : 0;
 }
 
 int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
diff --git a/net/lwip/nfs.c b/net/lwip/nfs.c
index 6b00c6ab3fd..3ecd259717a 100644
--- a/net/lwip/nfs.c
+++ b/net/lwip/nfs.c
@@ -123,6 +123,7 @@ static int nfs_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
 	ip_addr_set(&sess_ctx.nfs_server, &srvip);
 	nfs_use_rpcbind = IP_IS_V6(&srvip);
 
+	net_boot_file_size = 0;
 	nfs_download_state = NETLOOP_FAIL;
 	net_set_state(NETLOOP_FAIL);
 
@@ -182,13 +183,12 @@ static int nfs_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
 
 	if (net_state == NETLOOP_SUCCESS) {
 		ret = 0;
-		if (net_boot_file_size > 0) {
+		if (net_boot_file_size)
 			printf("Bytes transferred = %u (%x hex)\n",
 			       net_boot_file_size, net_boot_file_size);
-			env_set_hex("filesize", net_boot_file_size);
-			env_set_hex("fileaddr", image_load_addr);
-		}
-
+		if (env_set_hex("filesize", net_boot_file_size) ||
+		    env_set_hex("fileaddr", image_load_addr))
+			ret = -EIO;
 	} else {
 		debug("%s: NFS loop failed\n", __func__);
 		ret = -1;
@@ -197,14 +197,14 @@ static int nfs_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
 	return ret;
 }
 
-int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+int net_lwip_nfs_download(int argc, char *const argv[], const char *bootserver)
 {
 	struct net_lwip_ctx net = {};
 	int ret = CMD_RET_SUCCESS;
 	const char *arg = NULL;
 	char *arg_copy = NULL;
 	char *fname = NULL;
-	char *server_ip = NULL;
+	const char *server_ip = NULL;
 	char *end;
 	ip_addr_t srvip;
 	ulong laddr;
@@ -248,7 +248,7 @@ int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	}
 
 	if (!arg)
-		arg = *net_boot_file_name ? net_boot_file_name : env_get("bootfile");
+		arg = env_get("bootfile");
 
 	if (arg && *arg) {
 		arg_copy = strdup(arg);
@@ -281,6 +281,8 @@ int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 	if (!server_ip || !*server_ip)
 		server_ip = env_get("nfsserverip");
+	if (!server_ip || !*server_ip)
+		server_ip = bootserver;
 	if (!server_ip || !*server_ip)
 		server_ip = env_get(ipv6 ? "serverip6" : "serverip");
 	if (!server_ip || !*server_ip) {
@@ -315,3 +317,13 @@ out:
 	free(arg_copy);
 	return ret;
 }
+
+int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	int ret = net_lwip_nfs_download(argc, argv, NULL);
+
+	if (ret || !net_boot_file_size)
+		return ret;
+
+	return bootm_maybe_autostart(cmdtp, argv[0]);
+}
diff --git a/test/dm/lwip_ipv6.c b/test/dm/lwip_ipv6.c
index 193f4ee0b5d..5eb48adb92c 100644
--- a/test/dm/lwip_ipv6.c
+++ b/test/dm/lwip_ipv6.c
@@ -105,6 +105,7 @@ struct ip6_test {
 	bool advertise;
 	bool cancel;
 	bool fragment;
+	bool empty_nfs;
 };
 
 static u16 ip6_test_checksum(struct ip6_hdr *ip, void *data, unsigned int len)
@@ -688,6 +689,8 @@ static int ip6_test_rpc_reply(struct udevice *dev, struct ip6_hdr *ip)
 		reply[7] = htonl(32);
 		break;
 	case 5:
+		if (test->empty_nfs)
+			break;
 		reply[8] = htonl(9);
 		reply[9] = htonl(1);
 		reply[10] = htonl(9);
@@ -1448,6 +1451,22 @@ static int ip6_test_apps(struct unit_test_state *uts, struct ip6_test *test)
 	ut_assertok(run_command("nfs 2100000 [fe80::2]:/ipv6.bin", 0));
 	ut_asserteq_mem("ipv6-nfs!", data, 9);
 	ut_asserteq(7, test->rpc_requests);
+	if (IS_ENABLED(CONFIG_CMD_BOOTM)) {
+		ut_assertok(env_set("autostart", "yes"));
+		test->rpc_requests = 0;
+		/* The download succeeds but its contents are not a boot image. */
+		ut_asserteq(CMD_RET_FAILURE,
+			    run_command("nfs 2100000 [fe80::2]:/ipv6.bin", 0));
+		ut_asserteq(7, test->rpc_requests);
+	}
+	test->rpc_requests = 0;
+	test->empty_nfs = true;
+	ut_assertok(env_set("bootfile", "[fe80::2]:/empty"));
+	ut_assertok(run_command("nfs 2200000", 0));
+	ut_asserteq(6, test->rpc_requests);
+	ut_asserteq(0, net_boot_file_size);
+	ut_asserteq_str("0", env_get("filesize"));
+	ut_asserteq_str("2200000", env_get("fileaddr"));
 #endif
 #if CONFIG_IS_ENABLED(NETCONSOLE)
 	{
@@ -1477,7 +1496,15 @@ static int ip6_test_apps(struct unit_test_state *uts, struct ip6_test *test)
 
 static int dm_test_lwip_ip6_apps(struct unit_test_state *uts)
 {
-	return ip6_test_run(uts, ip6_test_apps);
+	char saved[sizeof(net_boot_file_name)];
+	int ret;
+
+	memcpy(saved, net_boot_file_name, sizeof(saved));
+	/* A previous DHCP lease must not override the current bootfile. */
+	strcpy(net_boot_file_name, "[invalid]:/old");
+	ret = ip6_test_run(uts, ip6_test_apps);
+	memcpy(net_boot_file_name, saved, sizeof(saved));
+	return ret;
 }
 DM_TEST(dm_test_lwip_ip6_apps, UTF_SCAN_FDT);
 

-- 
2.53.0

