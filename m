Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3763E606A330
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 22:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pE1k/Skh;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U3SNXx9r
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0982F4048D;
	Mon, 23 Nov 2026 22:29:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aq4YIIujUqoa; Mon, 23 Nov 2026 22:29:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 29ADB404DE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795472993;
	b=LVjwC/Hy7KzeHsCausWke6Pw0GRty/X8iIGLWtVWPPN8KLWsVrCFClasQqXmYSWuHjaJ
	 ib3uidF5Ia4T5gniBmkpzg6YtdSQ589vrWrizdKGJSafJaillyewfEiKRSmqaokYFKmCy
	 NKDiOodF2+Id4bR7zmpcwNa74dMR2VlOW+DnpF14/hQzm17lNidB7hpBUeAhzFaJzDNaZ
	 183s+NXCnADFweny9ZMeNkwMuJB3hhYgd8wssO37AOS9VyCDxFucwDu/x/S+aFeCJvMxP
	 JWZANEoq5zJpmW/Kq3u1yofzL/t/uienre6meZoA9Mahv1uUSnkj+kPq0o/Y5Xg2HiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795472993;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=cNmZoClD7menIO+IIKmgXvdnX3akSVC2Tf9JcfLm6lk=;
	b=TisaguRuVPJ25ipsvRRoKvdXFAPgIjedYJ0XJtVlslenPm5KtYdmLmQ8iD7LuFlnF7ie
	 xWiq+uW3cxZnwoIDxY+mW8VAlXNY3P49hECofTEVbkAmxQgWWqq9xcjKpuWpDKhDHaBre
	 EFDJg+Ar6qjkN2eDusw0kyDHGyq/p6EfM1qyFyONrNresKpD1rnQX/kH4trPFX8hTimqh
	 a6b6KD/QeAQArdgmdHLHTzE97kBFfWdWDQIBg/jFQ4D3Monn+uxjQhSIMlGJG37A00n1N
	 Du46MsNg9e9DJn6Cb33AjOSjsifsYZH1MQP5p6x9JWlYQuheinC0hMlLjQ6p1oQwm3A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795472993;
	bh=cNmZoClD7menIO+IIKmgXvdnX3akSVC2Tf9JcfLm6lk=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pE1k/SkhHq1UtZTUwoOXXrc92gHGl5+yqV4mX9F3n8ntK86C/d7rNAg4oX1CT9Uty
	 T05V7gGlsW8e1FYWsKivcp72K7vmKMv0lw67h8TbGADg/t+iUIdWsD9hakP4Aww9K1
	 yS/1g92Ae4tYgFWcujRzKFVRAO51piQKot73O4rfuw8GO5GW4C4IAxiWUNydiEUm/e
	 0BABAg+61hBEk1KMY8w+0taVfY0XcXHHJvjjp8qclxLYp4Jg60gIQGnsPXl3DrEqv9
	 vsqT2PhydQSgfuoSLVOJs6NYArlwP2DR8BVg3UQTSeO9yCh02z6he2W0qPuPqdeirC
	 NPFc2X87D+m6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29ADB404DE;
	Mon, 23 Nov 2026 22:29:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 76DD7499
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 22:29:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F4EA80BDD
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 22:29:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MBewMmHhzFs9 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 22:29:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 83DC480BD4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::229"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::229; helo=mail-oi1-x229.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=U3SNXx9r
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 83DC480BD4
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 22:29:49 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4e4a4d77e5bso3215724b6e.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795472988; x=1796077788;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cNmZoClD7menIO+IIKmgXvdnX3akSVC2Tf9JcfLm6lk=;
 b=U3SNXx9rG6JfXflM8VOK/Uzgr4uQXVI4u8ncx8+0XJPqCmFVU1921dO2CfF7vjKAh9
 oIfmepmQjA14c/bXd25psK9BMYlC5GuEeT6KfMy/y2i/QFQJvY/1dHa2J8VPs2DdfVRX
 hQdiAwwkM08S7XbglmKczzNYLRHk+docNnDG1QDnFd9kGcFcuOkSwTQFpeSF6rFQDil7
 LGD8blZvdBg6VI0yss/ArtlRoHzBqmdKIwRs+689F7FbvDEe/qdlTn7bATcCogN3ryQQ
 HMt5N2EPut5l13IqDlApKmOoyxfiigKNCmyb21yoq0jJhVmGablxBQ86RqATsbzu81K2
 njGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795472988; x=1796077788;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cNmZoClD7menIO+IIKmgXvdnX3akSVC2Tf9JcfLm6lk=;
 b=sUQiqJLt0JNs39dmq9VZpSgerqTlOianT2PcsOSRzRtcBJ0IF9EyzpjQUKH65Z3u9e
 tKNHMGqzoAr/kMC5oAperr8jocPUwQiKMkMNRCx5I//rhTi2JnJ4WoTEk+XDIqkJeb0r
 hHcsPeH3jGauYDFUhLMmdhW4q5A2999trbSswtszWm5eGQuoMrehjJYoxMzTXuw4IvPa
 eLDVJ8FK7DLI/9ZBvehQEcfGlxnSlXqkBrxdPe0XEyQjiBS/CrDLZ1uGe08E8b+HMEGi
 b4u5zxI+rb9w1a+PhWv8dmM6JLkN/zfIA9gQ5xU7m2bdu5r+NZkQhHa8kVAdCwhm7IZI
 imGg==
X-Gm-Message-State: APuU4Z9EV+FguT7BBI0bTkPVVhXoMPl0JJ8TfNPf5qvY1OaoRD3EykBb
 pqP7bOmTJQAUxegRs9NFqEr2ipv4jVQfsljTTvVAZ8xNZQzxg+BGppEt
X-Gm-Gg: AZFdTZeDu9YRQgxqDQyHTp40ZFrQf9P3FHMdSTYnszLMFONdFaBKzA8uol7w0hiV2c9
 lQCyv1cNMREy/LTtAkf74IpBmYZPEv90RoKBCpuPd5dgqW2a31IceDrCPa3YtbeExtnMxHk7oaQ
 c+LuaTU7AwT87QBf4muYjN1M5TmGG17qap786tZYZmy4Xndt4w8StRGJGlR4oEHpG+QO6DmdP28
 PAABB7nimS9RgfGLp55ORCkJWY5rJxBhv0L7vY3toCpsIOmVtSIhPvtPKBr+66eY9URuJxrhOKB
 mv5Pkc9ja+hJR2EfBtjqX6cg+0UFnk+pwb3T7cPGpNoVzw7sgH39ZRtOlBKeYyGNM5dO9oolFpR
 WuTZAse0WmTs//hwiKEoEpBHu8cMaxoqE4NIC//Ck7MM6GHKZ9ESs57YfomrzUydThLEE32EBpK
 tj5/m9oDlWVqBwUiINuOQzrHWS2QHPOb8QCtRwB4GE1fwVM/guhvryM+t9SpYZnj1alKCz7a34F
 4hObhUOYjwD34kAirt43RueSpsYrIsfXQjQRfQuMa/lpyktXGghsvEN8xF3n3H2b3LNmZNrB+SO
 dUfic7tI1vzPFvOvSKuw0iRq9wo9m9KzlHrEbsdiLZjoXt7h1OrkP5bNDmWbgbEf9fyu9yUzxdy
 V7yYW/XDfGG33iifK1ZPeknow5WOhNIzzZWCEhQ9hqvEnWBBnT1x6izuWG0yHoiKDbheB3BysQm
 Qv4yYFT1bWhxso8Xfmlca/6hex8t1HnG4/XSQtM7W9tnWP1H/8Pxw=
X-Received: by 2002:a05:6808:250f:b0:564:57c3:2b28 with SMTP id
 5614622812f47-57a095fcf70mr9773069b6e.8.1795472988256; 
 Mon, 23 Nov 2026 14:29:48 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a31929223sm10266254b6e.1.2026.11.23.14.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 14:29:47 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 23 Nov 2026 15:29:44 -0700
Subject: [PATCH] cmd: wget: honor autostart after a lwIP download
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-submit-lwip-wget-autostart-v1-v1-1-eb4959d4e4d7@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMAwA0F8hPduEDRzirxAPAwrUKJC1gAnh3
 5l6fJe3g1BgErgnOwRaWXgaI8wlgWbwY0/IbTTY1DpjbIay1G9WfG0849aTol90EvVBcTVYd9e
 SXHlzRZ5BPOZAHX9+f/X4OwZPavSbwnGc7iVMMYEAAAA=
X-Change-ID: 20261123-submit-lwip-wget-autostart-v1-bf59e6986743
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.17-dev
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With autostart=yes, the lwIP wget command returns to the prompt after
loading an image. The legacy command passes a successful nonempty
download to bootm_maybe_autostart().

Call the same helper from the lwIP command with image_load_addr set to
the download destination. Propagate the boot result to the caller.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/lwip/wget.c           |  5 ++++-
 doc/usage/environment.rst |  1 +
 test/dm/lwip_ipv6.c       | 42 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/cmd/lwip/wget.c b/cmd/lwip/wget.c
index c29b30ebe59..64f2362dd08 100644
--- a/cmd/lwip/wget.c
+++ b/cmd/lwip/wget.c
@@ -228,6 +228,9 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
 
 	if (wget_do_request(dst_addr, nurl))
 		return CMD_RET_FAILURE;
+	if (!wget_info->file_size)
+		return CMD_RET_SUCCESS;
 
-	return CMD_RET_SUCCESS;
+	image_load_addr = dst_addr;
+	return bootm_maybe_autostart(cmdtp, argv[0]);
 }
diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
index 80498853336..d64e78cf041 100644
--- a/doc/usage/environment.rst
+++ b/doc/usage/environment.rst
@@ -139,6 +139,7 @@ autostart
     * scsiboot - boot from SCSI device
     * tftpboot - boot image via network using TFTP protocol
     * usbboot - boot from USB device
+    * wget - boot an image downloaded over HTTP or HTTPS
 
     If the environment variable autostart is not set to a value starting with
     1, y, Y, t, or T, an image passed to the "bootm" command will be copied to
diff --git a/test/dm/lwip_ipv6.c b/test/dm/lwip_ipv6.c
index bd68ac0e356..741a6c1eaf8 100644
--- a/test/dm/lwip_ipv6.c
+++ b/test/dm/lwip_ipv6.c
@@ -87,6 +87,7 @@ struct ip6_test {
 	bool console_no_reply;
 	const char *http_host;
 	const char *http_target;
+	bool empty_http;
 	const char *boot_url;
 	const char *renew_boot_url;
 	const char *lease_dns;
@@ -615,6 +616,8 @@ static int ip6_test_http_reply(struct udevice *dev, struct ip6_hdr *ip)
 	struct ip6_test *test = ((struct eth_sandbox_priv *)dev_get_priv(dev))->priv;
 	static const char response[] = "HTTP/1.1 200 OK\r\nContent-Length: 9\r\n"
 				       "Connection: close\r\n\r\nipv6-http";
+	static const char empty[] = "HTTP/1.1 200 OK\r\nContent-Length: 0\r\n"
+				    "Connection: close\r\n\r\n";
 	u8 *tcp = (void *)(ip + 1), packet[20 + sizeof(response)] = {};
 	ip6_addr_t src, dst;
 	unsigned int header = (tcp[12] >> 4) * 4, len = IP6H_PLEN(ip), size = 20;
@@ -633,6 +636,9 @@ static int ip6_test_http_reply(struct udevice *dev, struct ip6_hdr *ip)
 		put_unaligned_be32(seq + 1, packet + 8);
 		packet[13] = 0x12;
 	} else if (len > header) {
+		const char *reply = test->empty_http ? empty : response;
+		size_t reply_len = strlen(reply);
+
 		if (!test->http_host ||
 		    !strnstr((char *)tcp + header, test->http_host, len - header) ||
 		    (test->http_target &&
@@ -642,8 +648,8 @@ static int ip6_test_http_reply(struct udevice *dev, struct ip6_hdr *ip)
 		put_unaligned_be32(1001, packet + 4);
 		put_unaligned_be32(seq + len - header, packet + 8);
 		packet[13] = 0x19;
-		memcpy(packet + 20, response, sizeof(response) - 1);
-		size += sizeof(response) - 1;
+		memcpy(packet + 20, reply, reply_len);
+		size += reply_len;
 	} else {
 		return 0;
 	}
@@ -1272,6 +1278,38 @@ static int dm_test_lwip_ip6_http_scheme(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_lwip_ip6_http_scheme, UTF_SCAN_FDT | UTF_CONSOLE);
 
+static int ip6_test_wget_autostart(struct unit_test_state *uts, struct ip6_test *test)
+{
+	const char *cmd = "wget 2100000 http://[fe80::2]:8080/ipv6.bin";
+	struct wget_http_info info = { .method = WGET_HTTP_METHOD_GET };
+
+	test->http_host = "Host: [fe80::2]:8080\r\n";
+	ut_assertok(env_set("autostart", "yes"));
+	image_load_addr = 0x2000000;
+	/* Internal clients fetch the same file without trying to boot it. */
+	ut_assertok(wget_request(0x2100000, "http://[fe80::2]:8080/ipv6.bin", &info));
+	ut_asserteq(0x2000000, image_load_addr);
+	ut_asserteq(CMD_RET_FAILURE, run_command(cmd, 0));
+	ut_assert_skip_to_line("Automatic boot of image at addr 0x02100000 ...");
+	ut_asserteq(0x2100000, image_load_addr);
+	image_load_addr = 0x2000000;
+	test->empty_http = true;
+	ut_assertok(run_command(cmd, 0));
+	ut_asserteq(0x2000000, image_load_addr);
+	ut_asserteq(3, test->http_requests);
+	return 0;
+}
+
+static int dm_test_lwip_ip6_wget_autostart(struct unit_test_state *uts)
+{
+	if (!CONFIG_IS_ENABLED(CMD_WGET) || !CONFIG_IS_ENABLED(CMD_BOOTM))
+		return -EAGAIN;
+
+	return ip6_test_run(uts, ip6_test_wget_autostart);
+}
+
+DM_TEST(dm_test_lwip_ip6_wget_autostart, UTF_SCAN_FDT | UTF_CONSOLE);
+
 #if CONFIG_IS_ENABLED(WGET_CACERT) || CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
 static int ip6_test_https_run(struct unit_test_state *uts,
 			      int (*check)(struct unit_test_state *, struct ip6_test *))

---
base-commit: d778970a189b977c14f93961d7009f404d895b5b
base-tree: https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git for-next
change-id: 20261123-submit-lwip-wget-autostart-v1-bf59e6986743

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

