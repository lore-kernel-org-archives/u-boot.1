Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCA3606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 13:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DD8jXODh;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=T27c5MKi
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF78D60EF2;
	Sat, 21 Nov 2026 13:15:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vY3JF6isbOD0; Sat, 21 Nov 2026 13:15:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7CB3560832
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795266888;
	b=LBfraO0R02E2MMliOpMYJz2/SgMBV3/HIrequzTZKrki5sO+fHkMiyGL1A6hMuJ1DmAk
	 bEVIibLqxJjVDIMhuSTzc2HINxMoRRK6SHDDSm6DURVgyX2nJHBD31+LsVYOAUat0Zhv7
	 m4/axCAYrtgT1tQ0n/p702RAsmZxcWHelaRfkhMa0ZVm5Re4aJ9OxI3owO+qj7c6vB4vH
	 4mkKkMzGOpJ733qfaNIKS/sstFA3TppLfJCSv6HLgUzuFr9PPDFGHhg/gtSMTIHSqEI2W
	 P8/yDkSbWuIcdsvTk80m6gFUptuZL10RmUn+BzNgiOcK24j5s2MHMNa/tDuHbvc3x4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795266888;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NE/lIKgu3sp3YG0/sADeEU3kLhDS4WYiOsU6g7IFV64=;
	b=VNeYDe4OEpwJsCbHSNaeF6AfTEsVAnDprDS2Wj23BQwq7RHHpU3fEVmVWSeQEM6W/YOs
	 NulNRxHScfE+kHFUneC0znyc53XQnu6NGLD0QgexBjRNhyVhmzS00p24mEw+7ORFTVWPY
	 6vbCaCdqsJkJzmiq9YeUZDd8tPEsPo6NaCf2JNsVmFITrNEVwFsqWzZOilL3YhEJ2jfHT
	 CZH+rssBzoB0aa/Imbmu9WkBhvWC/cmYuH4FlXRwsE06psZN07Lfpj0ppvc+ZS7OomlRn
	 wW/b5VXSoQkGskTt/fAHzPhNbGEa4DlU1Jk24rE4+RFK+bd71OIzSgrR0Q7Eyazkg/Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795266888;
	bh=NE/lIKgu3sp3YG0/sADeEU3kLhDS4WYiOsU6g7IFV64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DD8jXODh0G53T5EgsVTmQ8e5QxtOZDvwNfn1lc3O/nwjwmvQba5UjhxYOTDU6njsk
	 t+4Vjf1KrSKEwstekxhUHlmkdXzBgVgC5w1qg0xfP6tWEIlAz657waa9q6mRypDtii
	 ZcruW77OhkT1psFfcwXX3gPqPfhtPquJk3NyO3NZxCtYnC5XHxE2rBliEqMfw2pgY0
	 W6/YfdpHYugUEwYuLKvn9REkg6bLv6+LCS1zKPD3dNsI8+sitVCSfG7HK8TlLKIbje
	 Ju/pJljGY/yumndKm7A7NCvVsWWqGqLdAfHCMstwDPEa0PGKqB8GgmPcggb7C8dbNX
	 2iwtGyVdXcACA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7CB3560832;
	Sat, 21 Nov 2026 13:14:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 39F101AB
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:54:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C274400F5
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:54:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VUs2QZH0b1MI for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 11:54:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 061CB40012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::635"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=T27c5MKi
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 061CB40012
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:54:53 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c505a0acbc1so33951766b.2
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795262092; x=1795866892;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NE/lIKgu3sp3YG0/sADeEU3kLhDS4WYiOsU6g7IFV64=;
 b=T27c5MKioG0M8D9m6GHmPTZP+xgi8UgUG/ouN+X43Doiv9eofZx2y2D1yiNRgzFZMn
 G7IhwBwCnz/thQ/YZ1cY0Cgpq1kNcpWom3Ux5nsr/DAvr9UJEfxQTF4PEUhTltkLyOI/
 prkK3C3IGMmRkVRzzu6+wDEMbM69NmIIttbhCGPJGXCiygLEKc8K81uNyj4lEnYdw+Tb
 LHzRgmO+hQdTc1Vxg0ApXt++WKGdmqpJzqNt88PELW2yArdydrs5vbcmY1nMtH8ieBod
 Iz5YRyi9GIZscIKcWdDydahmeVbB2u9eHpmU8WtbZh8XLfoFSS5ZjwjAyOaCe2+PhcfR
 TRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795262092; x=1795866892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NE/lIKgu3sp3YG0/sADeEU3kLhDS4WYiOsU6g7IFV64=;
 b=TBNVqQIarNj+GmNQVynd4yaIvTETCQ0v3hmdDAxNv6fEq1f/UkhLDG0IWec42bFt+y
 S3aTuMGefz0gY35ZQwxh2yVtjcTWK7SXPkWnGy60uutdyJX55dp0geLC6HnwAovNwyO8
 zgRmqZnrNq4IijR7XAzCKnx1zlc0T7dh1zpa5EsUNndqlVAvpg2Famwod+rqUwD7kWOe
 jvPryvsWGnZRVV4XC+3K2vhqjKMw9B4fOM33/fhRFLwoaM9tcutlXL7wgpOJGeZfMPt/
 JtwC5gttj4NnzYRmQSUyvE/Y7YSBRzkbdM+C02o0VJyMu2txZDoJF92zYRezLeyRGiWf
 So9Q==
X-Gm-Message-State: APuU4Z9xZoVTm/FoQLEMdpYb4Ku6H8BLFRkd0Z1/x10lI/ZQHa91+DRc
 mkBIh9z/V/bZQh6iUc60Qb+EW+wEGlXSOk8WjarXNa8oEpTJKEyIrNrfisFTeQ1uh02xAcwKaA0
 yTWyD
X-Gm-Gg: AZFdTZfGnIht+oGL8Vtb4A1YFmN3FeRpEPfx2u07qsQOHFRs7nK1BCxqpbQpXYnvqoN
 FN+tpLceup/esTA3LPNrg8G3202bvUr1jZBNIXeolfzZ5chqm3Rsnq/1z2MLtdOuT0LwvbnNHRi
 C+LDzm3zJ28VLp5/SlJhV+ZcVGcQXUrPSLutb5yxovqdA1eXFaFryhDv/9NSbtI/XdC8R7qmGIg
 sYUsivzURPfNM/SxUXZcoyuvkcCB6HPwElGiFxQMeYC97jC8zpzW+aZ9FNG3ECybEPX6szaJrgU
 3ORsUM7+hntupMaPOh4OPJbJDTD58/WzjKYct/KVvJQZ1fkbXWz25dn+yAXOodvM55ukb7svpdw
 Zdy0Sm2Y+AAcXb1lzzj2kqcMF/+OBZDGFWxKntmvRKO2FDx5nAErNbdE8WU7Vj8dYctiii1XWx8
 EBD7v1V8kTGGP+/knkdP/h0T2HBJoMPCd7XXiFBusWwmz/68IUZ8kcaTjy5wxxkDGVxYfopeNAE
 7kS2e3mfsE6TzQigJHHVM8My0i2j2rg+YVyFODa7ZWQRrCPokA8fMMtoTDHXHwWqKDoqlcSZa2W
 BbRJoorfC/wrghNdoDYCm9vr6mwB7rF7eIN4GFFzWK5WTypPjmRohLZI0qUDwJYQdR0WVY8f5NI
 TQEWTHVD52A==
X-Received: by 2002:a17:907:932:b0:c51:8bf:9f22 with SMTP id
 a640c23a62f3a-c513a5c0549mr497312866b.2.1795262091819; 
 Sat, 21 Nov 2026 03:54:51 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513a8678cdsm186595766b.0.2026.11.21.03.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 03:54:51 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v12 19/31] usb: gadget: ci_udc: set endpoint capabilities
Date: Sat, 21 Nov 2026 12:53:23 +0100
Message-ID: <20261121115335.548142-20-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121115335.548142-1-anders.roxell@linaro.org>
References: <20261121115335.548142-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Nov 2026 13:14:06 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The resynced epautoconf.c matches endpoints on the caps field, not on the
name. ci_udc never fills caps in, so usb_ep_autoconfig() finds no endpoint
after the resync.

ci_udc keeps its endpoints in a static table, so set caps and
maxpacket_limit there instead of calling usb_ep_set_maxpacket_limit().

The names say what each endpoint is: ep1in-bulk, ep2out-bulk and
ep3in-int are fixed type and direction. Entry 4 is the template for
ep4 and up, those are free, so let them take any type and direction.

Tested on an i.MX93 board with ums.

Suggested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Link: https://lore.kernel.org/u-boot/87v7az6l03.fsf@kernel.org/
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/ci_udc.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index 9291cf9e61ef..26c683448f4a 100644
--- a/drivers/usb/gadget/ci_udc.c
+++ b/drivers/usb/gadget/ci_udc.c
@@ -121,28 +121,57 @@ __weak void ci_init_after_reset(struct ehci_ctrl *ctrl)
 static const struct usb_ep ci_ep_init[5] = {
 	[0] = {	/* EP 0 */
 		.maxpacket	= 64,
+		.maxpacket_limit = 64,
 		.name		= "ep0",
 		.ops		= &ci_ep_ops,
+		.caps		= {
+			.type_control	= 1,
+			.dir_in		= 1,
+			.dir_out	= 1,
+		},
 	},
 	[1] = {
 		.maxpacket	= 512,
+		.maxpacket_limit = 512,
 		.name		= "ep1in-bulk",
 		.ops		= &ci_ep_ops,
+		.caps		= {
+			.type_bulk	= 1,
+			.dir_in		= 1,
+		},
 	},
 	[2] = {
 		.maxpacket	= 512,
+		.maxpacket_limit = 512,
 		.name		= "ep2out-bulk",
 		.ops		= &ci_ep_ops,
+		.caps		= {
+			.type_bulk	= 1,
+			.dir_out	= 1,
+		},
 	},
 	[3] = {
 		.maxpacket	= 512,
+		.maxpacket_limit = 512,
 		.name		= "ep3in-int",
 		.ops		= &ci_ep_ops,
+		.caps		= {
+			.type_int	= 1,
+			.dir_in		= 1,
+		},
 	},
 	[4] = {
 		.maxpacket	= 512,
+		.maxpacket_limit = 512,
 		.name		= "ep-",
 		.ops		= &ci_ep_ops,
+		.caps		= {
+			.type_iso	= 1,
+			.type_bulk	= 1,
+			.type_int	= 1,
+			.dir_in		= 1,
+			.dir_out	= 1,
+		},
 	},
 };
 
-- 
2.53.0

