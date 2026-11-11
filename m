Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF5C606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=n/dYKhrv;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z3Fa1bl9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 96E4240DB3;
	Wed, 11 Nov 2026 20:11:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U1wYvKJMuRGX; Wed, 11 Nov 2026 20:11:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4426D40DE6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794427913;
	b=OOniBJ/UCSowUAnBLY3tnsC1xJcoFVFIZuVW/pSzyviBBMinpCAtG3XWfQOlZatrjIBk
	 g9dAKaRIURPzkYdEhYA9C1LLz6qcXw0kx/Z2AeL0L4xCuwkiuEyDLoGsWJ9FNRXrO4NZ1
	 f4uGMvOR6H85dx0h5Ga255lnvfIVJkSoOdaJSAVtjLtNSPG71SayM/Lrwy1Ya0uPAgTk6
	 SNDtou5VtoR3TZOgQNhdZmVJ4EOVEez/UpbDAz/uyiHYSciJuAoCwwvzYqmFyf/EqkkfU
	 0Re52l8KGX8XMRqqBWFUOJQIAkpHJxOGvSy1WlzIeN/PogyBIk8H3B2G6T7f95pP0Rw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794427913;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=m7ljYp5CmVTGsJowp77H9S6k+ELd8gxU+pDhaANBgkM=;
	b=Om4mkKIF2OO+7Lds7aElf0Virbob7H8DsC4nqmilE33/H3LAvrPKvkA7Q//G4pmJZJGk
	 sbi3U/5GjF7osDtO84C4nhWQ03sJdtX2mPXORO1I7lZ4QWKVFFxQW1Oa2v+SLI03DQBwv
	 64BpGis/tKkEdtGwLxZ2nEXuN4MwxgKrE8Mr0uPHiRMlwbwftnk5jd0vH3axU2lJItoX/
	 iOj1ZHUrkT2eQWmNTSqE/atPyEV43GR2ZWCi/uV6mjU3ukFM0uBBtcb3LyHMipdWR0YfI
	 4jpPm9FiNlYprZ5DxI6PgtsmPHIcnCELUFKZSeeMq8HCRcM5V4lJGrvyyRAz66O7/lQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z3Fa1bl9;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794427913;
	bh=m7ljYp5CmVTGsJowp77H9S6k+ELd8gxU+pDhaANBgkM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n/dYKhrvwhxnwcYQjMYXod+DfPEsDQNxoaSS82rM9aluLySrZyT/11xahDjDnie5y
	 bmsWCj1f5xV/I5TV0l1XU/MQ/3ZWMd18LKGEf5/End3gv26fh3Tv0dDOwC3uCHEseK
	 Nsm9aOyuVRdIcAlhCI5vb+dUj0C553EmGfbNFRnG+UXLm3HvKgB9568AAEUz+ZvPR+
	 7pER9ZWaAK6WUfz8EXV1LmwwEwBefFZEm+mEmUhGgoFYWMIuDAgISRfdLt+ZFCKFdf
	 FHoLwvJiQq35XL7odGXLIJZ1/G47goKCRncGJ/cZxfaYsh3H9oxxQrGZz5mimKCAFb
	 97hX3mmP2W1dA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4426D40DE6;
	Wed, 11 Nov 2026 20:11:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 647C6EC3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 566F540DB7
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PMdTTEClyysR for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 20:11:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8756240DB1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=z3Fa1bl9
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8756240DB1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:39 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-8253bc5a613so1979801a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794427898; x=1795032698;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m7ljYp5CmVTGsJowp77H9S6k+ELd8gxU+pDhaANBgkM=;
 b=z3Fa1bl9xbW6qNxxoeE4eswLHSgjBx776E5S8q4EEcqGwtZ8A5DL1+LA1diJ0znTAp
 nrRegbYLoHoeG2QpYar4AvsbzsGUBhRM2340xi/3x8iGGYVHtl8QIYerdjlFZWlIZJxF
 v522V4br7Ap+Mrzl78YqLlJGOQjVqf2+1D1wtmFPkMy7nH45VI2BQuuSGBhTx8mQgYZp
 ScgfMnJyEVYVad8l+ZENT4K75lsJRuCRET4DM1FubRDqmiSlFNmjI5BVD/zX+yUcr/xR
 1A5dlQ9z7fIfpKQw/w29AJddhkWRfeDYSwgtz8tDuh+AINwT+4BL8+nwxxvAqj0qCcbd
 jhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794427898; x=1795032698;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m7ljYp5CmVTGsJowp77H9S6k+ELd8gxU+pDhaANBgkM=;
 b=qqk6AeKry59o6/r/QzI6b9ZwZO5AEWoip7dv9gpPcSI84H5YttRM7lt4AmWBY0UIbk
 Z0hYpnNY1bfr9cKLkt+lS0yz+kCZd12/6SAruIdVKywZP835+kl0jm8PCsvlSsVPi+0u
 8eIIilYru5XxDoJ86kMCuZt33y6TkEBPokPjQ2jUsZpbmUon7deo66dicbrHRfHRZWsI
 7Pi/b8FeOm29b2pFRXlrSLfC9MstV03oPWqsCxUEJy0Xwp3tVQ0rKVVD4uANJsr/t5fj
 0Cmd8NWnBm8uBwzshU+4n+grtEquEryzoTNNZvYDTvgSfegAjJZLsWfI9XKav5fDTXKm
 OCew==
X-Forwarded-Encrypted: i=1;
 AL+hErEbRsOrCr9Lk3gFiHaueyYYRIGPf55iaZIClHJ/zZ8yor6raxCUZh+7agKoDCu/wliVNBrIgp4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9/8eeJIstaiTwj7dgpxfrwM3mvAvkEou0nuNZLycMvd/O+ZSpL
 CoKk7lNmeFMmmagTMlUlv0Ixz8Ls7dAuA2FBgl+wLwZAungpzNTvUobm
X-Gm-Gg: AYBFou3xjvxyiJabEMuUZkmoyfwuRqBxN3yYGK3Jgp3TQUVJqMuzMd/TsS4qR34NQwY
 qcVfxClusE+stc+RGWbfbwfKN/TmY4sIzPJK7oxXeAWjGCn3ghpon/bkFjFDSbX5tZ9bBnImfEW
 b7OEUzpKMEEtrgPADKKJ6zwEhuSRxIyLfuBHj4wJfrCuwY3RUajkW3FoSJiK8/dbgFF2KrOFfMh
 l3ReLamejzsRRqXvXHkj5rnCsGNHjOdpIArkXrMljzmea75B5iDScgGTnYQtS/QLTl/D6af8eN1
 Q0ua4Cq+kNI2y02EUHOvYWJYjcvKEgE7VJLuyvpduBPemcYx6Sx7cuvJhuMc0KITLMGcR1Za64m
 GmCYpwZ0UgPbskPxrHHUD6tup77XOoQJlAgLeBQKPiNPKrIPzMbgH0jhWhZ0OqUUGPBpfz6lh4j
 jFvro/25xeWVfdUAizPxjhuRkZe0exjAzqKgH/Y1aZMyXK12RHHK+mINUdVEyJnpvN8s2+1nkoU
 OTk/ic360Pq80SdpM1BGIsTuVHDNzGx6GNOjVwBJo596Ts5YWXztWUWoS7woAJY19XWt/XJgNU9
 h3NqyGJ4KHWm8RuSxN9aOSqOTtln9QE6g09MPRrOAMM6ZUIX/ek0AN709bI2UgrQwZxoh9VhXEC
 GNBkeIKYmil5wQI177P0v5a+EvLqPLo2OXcHyx9mGNUbtYWKYFWBCeiCayK8azLfVI8pvBI4Zgm
 dRLyfh9O3j1Ks10Rx50tz/2LuwzSa5ItTdpbYKG/zj1Sw2QYgoz4w=
X-Received: by 2002:a05:6808:c177:b0:523:dee6:7ae0 with SMTP id
 5614622812f47-56b985282b3mr3004022b6e.58.1794427897997; 
 Wed, 11 Nov 2026 12:11:37 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56905d3bab2sm5863446b6e.12.2026.11.11.12.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 12:11:37 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 13:11:23 -0700
Subject: [PATCH 16/19] net: lwip: load DHCPv6 HTTP and HTTPS boot URLs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-submit-lwip-ipv6-v1-v1-16-eb0ee8f8da1a@gmail.com>
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

Pass HTTP and HTTPS boot URLs to wget, preserving the original hostname
and the configured TLS verification policy. Resolve relative filename
overrides against the advertised URL directory and absolute paths against
its origin. Bound the directory search to the path so slashes in a query
or fragment cannot redirect filename replacement. Supply a root slash
when the advertised URL has an empty path and check the combined length
before replacing the filename.

Use boot-download options so reserved-memory checks and boot-device
tracking match the wget command. Restore the previous request context and
publish the downloaded size only after a successful transfer.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 net/lwip/dhcp6.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/net/lwip/dhcp6.c b/net/lwip/dhcp6.c
index 1068c842752..034a76442ef 100644
--- a/net/lwip/dhcp6.c
+++ b/net/lwip/dhcp6.c
@@ -824,6 +824,34 @@ static int dhcp6_bootfile(struct dhcp6_client *client, char *file, size_t size)
 	return ret;
 }
 
+/* Resolve a filename against the advertised HTTP URL's path, not its query. */
+static int dhcp6_http_override(char *url, size_t size, const char *filename)
+{
+	const char *path, *end;
+	size_t prefix = 0;
+	bool slash = false;
+
+	if (!strstr(filename, "://")) {
+		path = strstr(url, "://") + 3;
+		path += strcspn(path, "/?#");
+		prefix = path - url;
+		if (*filename != '/') {
+			end = path + strcspn(path, "?#");
+			for (const char *p = path; p < end; p++) {
+				if (*p == '/')
+					prefix = p + 1 - url;
+			}
+			slash = *path != '/';
+		}
+	}
+	if (prefix + slash >= size || strlen(filename) >= size - prefix - slash)
+		return -ENAMETOOLONG;
+	if (slash)
+		url[prefix++] = '/';
+	strcpy(url + prefix, filename);
+	return 0;
+}
+
 static int do_dhcp6(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	struct net_lwip_ctx net = {};
@@ -887,10 +915,14 @@ static int do_dhcp6(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[
 			goto out;
 	}
 	if (filename) {
-		if (strlcpy(file, filename, sizeof(file)) >= sizeof(file)) {
-			ret = -ENAMETOOLONG;
+		if (offered && !tftp_url &&
+		    (!strncmp(file, "http://", 7) || !strncmp(file, "https://", 8)))
+			ret = dhcp6_http_override(file, sizeof(file), filename);
+		else
+			ret = strlcpy(file, filename, sizeof(file)) >= sizeof(file) ?
+				-ENAMETOOLONG : 0;
+		if (ret)
 			goto out;
-		}
 	} else if (!offered) {
 		filename = env_get("bootfile");
 		if (strlcpy(file, filename ?: "", sizeof(file)) >= sizeof(file)) {
@@ -909,6 +941,26 @@ static int do_dhcp6(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[
 		ret = -ENOENT;
 		goto out;
 	}
+	if (CONFIG_IS_ENABLED(WGET) && (!tftp_url || filename) &&
+	    (!strncmp(file, "http://", 7) || !strncmp(file, "https://", 8))) {
+		struct wget_http_info info = {
+			.method = WGET_HTTP_METHOD_GET,
+			.set_bootdev = true,
+		};
+		struct wget_http_info *saved = wget_info;
+
+		net_boot_file_size = 0;
+		ret = wget_request(load, file, &info);
+		wget_info = saved;
+		if (!ret) {
+			net_boot_file_size = info.file_size;
+			ret = env_set_hex("fileaddr", load);
+			if (!ret)
+				ret = env_set_hex("filesize", info.file_size);
+		}
+		downloaded = !ret;
+		goto out;
+	}
 	if ((offered && !tftp_url) ||
 	    ((!tftp_url || filename) && strstr(file, "://"))) {
 		ret = -EPROTONOSUPPORT;

-- 
2.53.0

