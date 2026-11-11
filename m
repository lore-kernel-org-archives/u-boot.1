Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559EC606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=btImJ2im;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t1OC5xO0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3069440931;
	Wed, 11 Nov 2026 20:11:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iu2-Vnr93R2t; Wed, 11 Nov 2026 20:11:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 99D5440DDD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794427908;
	b=EKntTVGKeXBDDT4R2RTlX85h7uxUL7CzghO9xI/VdU0VkXd7f1Rh4fmCoM+wXf6UcCAE
	 9HtGM0IKJMmMH5SBf5HtZuQ3wjzGuE2HHOeP5nfatJfuQmGCUopW7yM/90Wd1vEZODSmw
	 fpHQvrZr3gzNDiGl09SdbY2k9iKrz0yWoZrMMroV/HIzeheQn7z4k9ZvVXlzWoMk7DU9Z
	 q3tqsYYJt8OrdeH99JQpYtVGGoJJQNDt3ACBPHSH7dInN+toYHVnI97qoJMtQMeLJ9uOO
	 IgRgfftZ3UVVvz/6VrDXaeQp4k/3Fe6FmjQWMiUlRDhdOk8LfDpCwbhU71EvuiAdBHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794427908;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6m//CDxO1g+/YuSez1dq/zT+JvEzGOyWOTBz50onihE=;
	b=YDAIJ/4RS1CaJnY73T3xd4SHROasSPDDatVP8m0eTvrvAkTnHj7VPmF/XySrkLWCp2Xv
	 ZERdqOz2l6iLa10W2R/kavTf/kbdZTJdgNhQJne4wG2Sc3BsUrQTDnfSavTnIQWPe7MUQ
	 KHN7AyVxrvf7n1HcQ+IbmQlZmzlOWKDYd9v+vc6TK3Za7fOJ0XUfX/SyJ+8qGlNRSvEE5
	 WWCXiAZtEtKOtAKTDvoiyoF6YxTBcIr6l4Xd65y/Y01i9umXgsEhtKGH/BPjx6ahH67sG
	 UrlAJ4ZOM0+w4kb/dlt8ZhDqtypx7OsHpk659IYkfEL9WrvWJijKYpWI22tDDYqB4Fw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t1OC5xO0;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794427908;
	bh=6m//CDxO1g+/YuSez1dq/zT+JvEzGOyWOTBz50onihE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=btImJ2imShanyw8cfJcGdWcO1oqMX5uF+1aXQCimpFJ45s9da9gcx/l4iy4qtj7B2
	 gbbGfTNpUoAWGRny0wMqd7XXMzv21lKDaPxrngSZq7ReUxfEEGgGg75UDIgSdpdpIf
	 DhwQI38SqMQkp5pQXLVkTU0qw9xxm7uGTRfmchhHo0ABlBkmNtzy6noM4deELf7YkA
	 wyfiP2nrHiv3h+6vlXGJOjS/3RWhuoQclD+aYMl9LlZC0gdaltMsHTV4uevMy8SJXu
	 gWIcHKPEvfoq4WmJInd8kpXNfVBvUP5G1dUMNQFge9FoeaTw/xmfEKhbvpuqMUhXSd
	 Cc2OvlPQMKKxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99D5440DDD;
	Wed, 11 Nov 2026 20:11:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BF252FE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E395F4099C
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cO40yPNQX4Ge for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 20:11:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AEE59408F9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::229"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::229; helo=mail-oi1-x229.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=t1OC5xO0
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AEE59408F9
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:34 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-56431524c22so1236568b6e.0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794427893; x=1795032693;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6m//CDxO1g+/YuSez1dq/zT+JvEzGOyWOTBz50onihE=;
 b=t1OC5xO0l93yvi/z6jwVUwIfop4WNQCtANi/+GoYsEnKuQ8s2qBbydQAhsej2n+RDj
 m2MzxXeXR08u1dEVJ+vlkmyr0U94cBdZOuRgP9FkNmC3Sar6Mu8C6ZR+Zh5bdZl9eofH
 /V3Z5B1JNvkxf4kILhJxp2JoY+PkFtCD5CyFbmNcgerQI4qSnnK80+qUnVt+HFH+m5D7
 995sNoqQcs+QdmMISrWy/VFMI2he2+97IxFZwDomGnk2z3vAkRB8IgYbSAt7dnYut1Fq
 reA6idEHFYh0jQoROle6cr5Yx6d9iaiOg9QU52+G33KDiqrI2HJu1OI8/LRnnCPsvzUf
 euww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794427893; x=1795032693;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6m//CDxO1g+/YuSez1dq/zT+JvEzGOyWOTBz50onihE=;
 b=e/mygvQ76IXBVOcl/jmqE+1ZQU0uxqHb6egizpVpvbh2QTKleGZQII/Mz69u3aeJsX
 1JGeM0yuO7BDB5ITex36DL/RQ3PuTSeJSnGq+ncZtNHhWJ7zI2XUAKJFZMtEiPSy026z
 04I24qH00LeGOnkznVQy3MIPiDbMjMosE7RUmk4w5+kP1BOsTFJymgD1RAaw9UL2pu4M
 6f9fhgj2nFPO2WcnwqvSt9jq+/TldmCk8EaXPatqTp/yf8NLUMd51PC8/sV7mfNNlg47
 O1mmxWFu4cBvRW14qmNMU8OKEndyCwnNWLwDTqwU3ISW1zKnOEL2ETLKNaiFnq2g5STB
 DBww==
X-Forwarded-Encrypted: i=1;
 AL+hErENyT7nksPy5J7vNS3ODNGKr1DpQlFdLNBSVmmEoyzVndQ5mCdi5/50aPLPXxMkFYZSNjUJJhg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9WIJFMesVYRtmg0f6MZWg6PKv9UTOMNm7WUrGJIhcskVls4Ozm
 mM2ACu9jxYvr61SMZortrxGiNY0WMqVN2+3CMyRNI9k1At7BhXN3o2QC
X-Gm-Gg: AYBFou0Nno1jd4cbIAoC637V0OCN2i5MbRRAThnJKwVbR+IluxKAn7dpVWWryKNNmLy
 +0SWFVnVXwj9qsE9uA0H530yswlA24uGLQUfdFf1LVV0fPIAI4clO3T5PvBrqEjQUENgqwiPai1
 9bawzKFzgghNMtud1Hur4Kz9awHpmeOabHrZxgrEu8O20SZ7dfIJqrzfzdxjnj5FDBc8O/SgNt+
 azwZ607x5NqSP62UiehJgXmDULKiOB+12fA2KUBpyd8Il32juSbdyMOIGCnXu52LDmZLpjUGfWU
 +QneQmo0rKD2j+hWH/Ej5uFGZTXB36/BRDgy6bfV/A0jYBj9IMsYFT9daTi88VslMn2bU8zQyQx
 M80ECbplZQy9zRK6pBkakYCGnk85dx1er8xG/lUnnk7z1MPE7UvwDdi3hjR/g+luxcpk47x9EwJ
 grc3P9jBMbH8lmiXbaYGPUCqbkFusUjL+iCfQ6/+NqeXhIW90KQ++dpVSIJb2QHDt+P/SDK4QPS
 w6CJPmUY0R8aa1Mf8PuQfMzTAxjVnYHQqfkaRgGNGoGbqo+n5AZmRn4Q5tpfBFjJ8ct0ux1I87Q
 iKky9vjU9Np1zeqI1+A0+rBOYYu7bUwZ5h3Xi2+HlfVclvNI8foOnkVzOKj9KBMGFk6ghWWvNOh
 sGQAznqRN52MwtCwd4iin+YstxqkxmVex8A66GaxjsemmgRs03NSPA6hcrIQUoZmDCng62wQBsB
 Vy79g6gKvYq38RhoR7//wolH5rf7wdFOF/VSg3No9UvggFRQU6Rco=
X-Received: by 2002:a05:6808:e84:b0:4f4:73a9:f838 with SMTP id
 5614622812f47-56b9629d250mr2980467b6e.22.1794427893033; 
 Wed, 11 Nov 2026 12:11:33 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56905d3bab2sm5863446b6e.12.2026.11.11.12.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 12:11:32 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 13:11:19 -0700
Subject: [PATCH 12/19] net: lwip: support IPv6 NFS and SNTP servers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-submit-lwip-ipv6-v1-v1-12-eb0ee8f8da1a@gmail.com>
References: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
In-Reply-To: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Igor Velkov <iav@iav.lv>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Murtaza Munaim <murtaza@saramena.us>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Drew Kluemke <ankluemk@microsoft.com>
X-Mailer: b4 0.15.2
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

Resolve NFS and SNTP server arguments in the active network context and
prepare the selected address family before starting their UDP traffic.
Accept bracketed IPv6 NFS paths and serverip6 with a trailing -ipv6 flag.

Use RPCBIND v3 GETADDR with the udp6 netid for IPv6 NFS and mount service
discovery. Decode the universal-address port with bounded XDR parsing,
while keeping portmapper v2 for IPv4.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/lwip/nfs.c      |  5 ++--
 cmd/lwip/sntp.c     | 36 ++++++++++++++++----------
 include/net-lwip.h  |  1 -
 net/lwip/net-lwip.c | 20 ---------------
 net/lwip/nfs.c      | 48 +++++++++++++++++++++++------------
 net/nfs-common.c    | 73 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 net/nfs-common.h    |  2 ++
 7 files changed, 125 insertions(+), 60 deletions(-)

diff --git a/cmd/lwip/nfs.c b/cmd/lwip/nfs.c
index f22db582fdb..cfa435c2bcd 100644
--- a/cmd/lwip/nfs.c
+++ b/cmd/lwip/nfs.c
@@ -4,8 +4,9 @@
 #include <command.h>
 #include <net.h>
 
-U_BOOT_CMD(nfs,	3,	1,	do_nfs,
+U_BOOT_CMD(nfs,	3 + IS_ENABLED(CONFIG_IPV6),	1,	do_nfs,
 	   "boot image via network using NFS protocol",
-	   "[loadAddress] [[hostIPaddr:]bootfilename]"
+	   "[loadAddress] [[host:]bootfilename] [-ipv6]\n"
+	   "Bracket IPv6 addresses: [IPv6address]:bootfilename"
 	  );
 
diff --git a/cmd/lwip/sntp.c b/cmd/lwip/sntp.c
index 25b76f58b06..c1e47c8ee47 100644
--- a/cmd/lwip/sntp.c
+++ b/cmd/lwip/sntp.c
@@ -56,6 +56,8 @@ static bool ntp_server_known(void)
 
 static int sntp_loop(struct net_lwip_ctx *net, ip_addr_t *srvip)
 {
+	int ret;
+
 	sntp_state = NOT_DONE;
 
 	sntp_setoperatingmode(SNTP_OPMODE_POLL);
@@ -68,11 +70,22 @@ static int sntp_loop(struct net_lwip_ctx *net, ip_addr_t *srvip)
 			return -1;
 		}
 	}
+	for (unsigned int i = 0; i < SNTP_MAX_SERVERS; i++) {
+		ip_addr_t addr = *sntp_getserver(i);
+
+		if (ip_addr_isany(&addr))
+			continue;
+		ret = net_lwip_prepare_addr(net, &addr);
+		if (ret)
+			return ret;
+		sntp_setserver(i, &addr);
+	}
 	sntp_init();
 
 	sys_timeout(SNTP_TIMEOUT, no_response, NULL);
 	while (sntp_state == NOT_DONE) {
-		net_lwip_poll();
+		if (net_lwip_poll() < 0)
+			break;
 		if (ctrlc()) {
 			printf("\nAbort\n");
 			sntp_state = ABORTED;
@@ -92,27 +105,17 @@ static int sntp_loop(struct net_lwip_ctx *net, ip_addr_t *srvip)
 int do_sntp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	struct net_lwip_ctx net = {};
-	ip_addr_t *srvip;
-	char *server;
+	ip_addr_t *srvip = NULL;
+	const char *server;
 	ip_addr_t ipaddr;
 	int ret = CMD_RET_FAILURE;
 
 	switch (argc) {
 	case 1:
-		srvip = NULL;
 		server = env_get("ntpserverip");
-		if (server) {
-			if (!ipaddr_aton(server, &ipaddr)) {
-				printf("ntpserverip is invalid\n");
-				return CMD_RET_FAILURE;
-			}
-			srvip = &ipaddr;
-		}
 		break;
 	case 2:
-		if (net_lwip_dns_resolve(argv[1], &ipaddr))
-			return CMD_RET_FAILURE;
-		srvip = &ipaddr;
+		server = argv[1];
 		break;
 	default:
 		return CMD_RET_USAGE;
@@ -120,6 +123,11 @@ int do_sntp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 	if (net_lwip_start(&net, NET_LWIP_ADDR_ENV_STRICT))
 		return CMD_RET_FAILURE;
+	if (server) {
+		if (net_lwip_resolve(&net, server, &ipaddr, IPADDR_TYPE_ANY))
+			goto out;
+		srvip = &ipaddr;
+	}
 
 	if (sntp_loop(&net, srvip) < 0)
 		goto out;
diff --git a/include/net-lwip.h b/include/net-lwip.h
index ea5ec8a03ec..cf06a864adb 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -82,7 +82,6 @@ void net_lwip_stop(struct net_lwip_ctx *ctx);
 int net_lwip_restart(struct net_lwip_ctx *ctx);
 int net_lwip_refresh(struct net_lwip_ctx *ctx);
 int net_lwip_poll(void);
-int net_lwip_dns_resolve(char *name_or_ip, ip_addr_t *ip);
 int net_lwip_resolve(struct net_lwip_ctx *ctx, const char *name,
 		     ip_addr_t *addr, u8 type);
 int net_lwip_prepare_addr(struct net_lwip_ctx *ctx, ip_addr_t *addr);
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 545efe09720..96ed5723122 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -1002,26 +1002,6 @@ int net_lwip_poll(void)
 	return ret;
 }
 
-/**
- * net_lwip_dns_resolve() - find IP address from name or IP
- *
- * @name_or_ip: host name or IP address
- * @ip: output IP address
- *
- * Return value: 0 on success, -1 on failure.
- */
-int net_lwip_dns_resolve(char *name_or_ip, ip_addr_t *ip)
-{
-	struct net_lwip_ctx ctx = {};
-	int ret;
-
-	ret = net_lwip_start(&ctx, NET_LWIP_ADDR_ENV_STRICT);
-	if (!ret)
-		ret = net_lwip_resolve(&ctx, name_or_ip, ip, IPADDR_TYPE_ANY);
-	net_lwip_stop(&ctx);
-	return ret;
-}
-
 int net_lwip_resolve(struct net_lwip_ctx *ctx, const char *name,
 		     ip_addr_t *addr, u8 type)
 {
diff --git a/net/lwip/nfs.c b/net/lwip/nfs.c
index b435403169a..a389aa6412f 100644
--- a/net/lwip/nfs.c
+++ b/net/lwip/nfs.c
@@ -75,7 +75,7 @@ exitfree:
 
 static int nfs_udp_init(struct nfs_ctx *ctx)
 {
-	ctx->pcb = udp_new();
+	ctx->pcb = udp_new_ip_type(IP_GET_TYPE(&ctx->nfs_server));
 	if (!ctx->pcb)
 		return -ENOMEM;
 
@@ -104,6 +104,12 @@ static int nfs_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
 {
 	int ret;
 
+	ret = net_lwip_prepare_addr(net, &srvip);
+	if (ret)
+		return ret;
+	ip_addr_set(&sess_ctx.nfs_server, &srvip);
+	nfs_use_rpcbind = IP_IS_V6(&srvip);
+
 	nfs_download_state = NETLOOP_FAIL;
 	net_set_state(NETLOOP_FAIL);
 
@@ -117,8 +123,7 @@ static int nfs_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
 
 	printf("Using %s device\n", net->dev->name);
 
-	printf("File transfer via NFS from server %s; our IP address is %s\n",
-	       ipaddr_ntoa(&srvip), env_get("ipaddr"));
+	printf("File transfer via NFS from server %s\n", ipaddr_ntoa(&srvip));
 
 	printf("\nFilename '%s/%s'.", nfs_path, nfs_filename);
 
@@ -141,13 +146,12 @@ static int nfs_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
 
 	net_set_state(NETLOOP_CONTINUE);
 
-	ip_addr_set(&sess_ctx.nfs_server, &srvip);
-
 	nfs_send();
 
 	timer_start = get_timer(0);
 	do {
-		net_lwip_poll();
+		if (net_lwip_poll() < 0)
+			break;
 		if (net_state != NETLOOP_CONTINUE)
 			break;
 		if (ctrlc()) {
@@ -192,6 +196,12 @@ int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	ip_addr_t srvip;
 	ulong laddr;
 	ulong addr;
+	bool ipv6 = false;
+
+	if (IS_ENABLED(CONFIG_IPV6) && argc > 1 && !strcmp(argv[argc - 1], "-ipv6")) {
+		ipv6 = true;
+		argc--;
+	}
 
 	laddr = env_get_ulong("loadaddr", 16, image_load_addr);
 
@@ -234,11 +244,21 @@ int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 			goto out;
 		}
 		/*
-		 * Split the optional IPv4 prefix once. Keep the allocation base
+		 * Split the optional server prefix once. Keep the allocation base
 		 * for cleanup, and do not modify argv, bootfile or the global name.
 		 */
 		fname = strchr(arg_copy, ':');
-		if (fname) {
+		if (IS_ENABLED(CONFIG_IPV6) && *arg_copy == '[') {
+			end = strchr(arg_copy, ']');
+			if (!end || end[1] != ':') {
+				ret = CMD_RET_USAGE;
+				goto out;
+			}
+			*end = '\0';
+			server_ip = arg_copy + 1;
+			fname = end + 2;
+			ipv6 = true;
+		} else if (fname) {
 			*fname++ = '\0';
 			server_ip = arg_copy;
 		} else {
@@ -249,19 +269,13 @@ int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (!server_ip || !*server_ip)
 		server_ip = env_get("nfsserverip");
 	if (!server_ip || !*server_ip)
-		server_ip = env_get("serverip");
+		server_ip = env_get(ipv6 ? "serverip6" : "serverip");
 	if (!server_ip || !*server_ip) {
 		log_err("error: nfsserverip/serverip not set\n");
 		ret = CMD_RET_FAILURE;
 		goto out;
 	}
 
-	if (!ipaddr_aton(server_ip, &srvip)) {
-		log_err("error: ipaddr_aton\n");
-		ret = CMD_RET_FAILURE;
-		goto out;
-	}
-
 	if (!fname || !*fname) {
 		log_err("error: no file name\n");
 		ret = CMD_RET_FAILURE;
@@ -279,7 +293,9 @@ int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		goto out;
 	}
 
-	if (nfs_loop(&net, laddr, fname, srvip) < 0)
+	if (net_lwip_resolve(&net, server_ip, &srvip,
+			     ipv6 ? IPADDR_TYPE_V6 : IPADDR_TYPE_ANY) ||
+	    nfs_loop(&net, laddr, fname, srvip) < 0)
 		ret = CMD_RET_FAILURE;
 out:
 	net_lwip_stop(&net);
diff --git a/net/nfs-common.c b/net/nfs-common.c
index ad5b9cc1f48..a82b3b795a0 100644
--- a/net/nfs-common.c
+++ b/net/nfs-common.c
@@ -43,6 +43,7 @@
 #include <log.h>
 #include <net.h>
 #include <mapmem.h>
+#include <linux/ctype.h>
 #include "nfs.h"
 #include "nfs-common.h"
 
@@ -60,6 +61,7 @@ struct in_addr nfs_server_ip;
 int nfs_server_mount_port;
 int nfs_server_port;
 int nfs_our_port;
+bool nfs_use_rpcbind;
 int nfs_state;
 int nfs_timeout_count;
 unsigned long rpc_id;
@@ -211,6 +213,8 @@ void rpc_req_common(int rpc_prog, int rpc_proc, uint32_t *data, int datalen,
 		}
 		break;
 	case PROG_PORTMAP:
+		rpc_pkt.u.call.vers = htonl(nfs_use_rpcbind ? 3 : 2);
+		break;
 	default:
 		rpc_pkt.u.call.vers = htonl(2);	/* portmapper is version 2 */
 	}
@@ -238,12 +242,19 @@ void rpc_req_common(int rpc_prog, int rpc_proc, uint32_t *data, int datalen,
  */
 static void rpc_lookup_req(int prog, int ver)
 {
-	u32 data[16];
+	u32 data[10] = {};
 
 	data[0] = 0; data[1] = 0;	/* auth credential */
 	data[2] = 0; data[3] = 0;	/* auth verifier */
 	data[4] = htonl(prog);
 	data[5] = htonl(ver);
+	if (nfs_use_rpcbind) {
+		/* RPCBPROC_GETADDR: netid, universal address and owner strings. */
+		data[6] = htonl(4);
+		memcpy(&data[7], "udp6", 4);
+		rpc_req(PROG_PORTMAP, RPCB_GETADDR, data, ARRAY_SIZE(data));
+		return;
+	}
 	data[6] = htonl(17);	/* IP_UDP */
 	data[7] = 0;
 	rpc_req(PROG_PORTMAP, PORTMAP_GETPORT, data, 8);
@@ -502,8 +513,9 @@ static int rpc_handle_error(struct rpc_t *rpc_pkt)
 static int rpc_lookup_reply(int prog, uchar *pkt, unsigned int len)
 {
 	struct rpc_t rpc_pkt;
+	u32 port;
 
-	if (len > sizeof(rpc_pkt.u.data))
+	if (len < offsetof(struct rpc_t, u.reply.data[1]) || len > sizeof(rpc_pkt.u.data))
 		return -NFS_RPC_DROP;
 	memcpy(&rpc_pkt.u.data[0], pkt, len);
 
@@ -514,15 +526,52 @@ static int rpc_lookup_reply(int prog, uchar *pkt, unsigned int len)
 
 	if (rpc_pkt.u.reply.rstatus  ||
 	    rpc_pkt.u.reply.verifier ||
+	    rpc_pkt.u.reply.v2 ||
+	    ntohl(rpc_pkt.u.reply.type) != MSG_REPLY ||
 	    rpc_pkt.u.reply.astatus)
-		return -1;
+		return -NFS_RPC_ERR;
+
+	port = ntohl(rpc_pkt.u.reply.data[0]);
+	if (nfs_use_rpcbind) {
+		const char *addr = (const char *)&rpc_pkt.u.reply.data[1];
+		const char *end, *part;
+		u32 octet;
+
+		/* The universal address ends in two decimal UDP port octets. */
+		if (port > len - offsetof(struct rpc_t, u.reply.data[1]))
+			return -NFS_RPC_DROP;
+		if (!port)
+			return -NFS_RPC_ERR;
+		if (memchr(addr, 0, port))
+			return -NFS_RPC_DROP;
+		end = addr + port;
+		port = 0;
+		for (int shift = 0; shift <= 8; shift += 8) {
+			part = end;
+			while (part > addr && isdigit(part[-1]))
+				part--;
+			if (part == end || end - part > 3 || part <= addr || part[-1] != '.')
+				return -NFS_RPC_DROP;
+			octet = 0;
+			for (const char *p = part; p < end; p++)
+				octet = octet * 10 + *p - '0';
+			if (octet > 255)
+				return -NFS_RPC_DROP;
+			port |= octet << shift;
+			end = part - 1;
+		}
+		if (end == addr)
+			return -NFS_RPC_DROP;
+	}
+	if (!port || port > 65535)
+		return -NFS_RPC_ERR;
 
 	switch (prog) {
 	case PROG_MOUNT:
-		nfs_server_mount_port = ntohl(rpc_pkt.u.reply.data[0]);
+		nfs_server_mount_port = port;
 		break;
 	case PROG_NFS:
-		nfs_server_port = ntohl(rpc_pkt.u.reply.data[0]);
+		nfs_server_port = port;
 		break;
 	}
 
@@ -780,15 +829,25 @@ void nfs_pkt_recv(uchar *pkt, unsigned int len)
 
 	switch (nfs_state) {
 	case STATE_PRCLOOKUP_PROG_MOUNT_REQ:
-		if (rpc_lookup_reply(PROG_MOUNT, pkt, len) == -NFS_RPC_DROP)
+		reply = rpc_lookup_reply(PROG_MOUNT, pkt, len);
+		if (reply == -NFS_RPC_DROP)
+			break;
+		if (reply) {
+			net_set_state(NETLOOP_FAIL);
 			break;
+		}
 		nfs_state = STATE_PRCLOOKUP_PROG_NFS_REQ;
 		nfs_send();
 		break;
 
 	case STATE_PRCLOOKUP_PROG_NFS_REQ:
-		if (rpc_lookup_reply(PROG_NFS, pkt, len) == -NFS_RPC_DROP)
+		reply = rpc_lookup_reply(PROG_NFS, pkt, len);
+		if (reply == -NFS_RPC_DROP)
 			break;
+		if (reply) {
+			net_set_state(NETLOOP_FAIL);
+			break;
+		}
 		nfs_state = STATE_MOUNT_REQ;
 		nfs_send();
 		break;
diff --git a/net/nfs-common.h b/net/nfs-common.h
index a19b98b7b1f..b48e035c6a8 100644
--- a/net/nfs-common.h
+++ b/net/nfs-common.h
@@ -11,6 +11,7 @@
 #define PROG_PORTMAP    100000
 #define PROG_NFS        100003
 #define PROG_MOUNT      100005
+#define RPCB_GETADDR    3
 
 #define MSG_CALL        0
 #define MSG_REPLY       1
@@ -52,6 +53,7 @@ extern struct in_addr nfs_server_ip;
 extern int nfs_server_mount_port;
 extern int nfs_server_port;
 extern int nfs_our_port;
+extern bool nfs_use_rpcbind;
 extern int nfs_timeout_count;
 extern unsigned long rpc_id;
 extern int nfs_offset;

-- 
2.53.0

