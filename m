Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E417A606A332
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WEYYqLpE;
	dkim=pass (2048-bit key, unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=LRaPqJ1l
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60E4E60697;
	Fri,  6 Nov 2026 07:27:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qlmQrulsQsgf; Fri,  6 Nov 2026 07:27:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 97F15605F7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793950072;
	b=SaMTancVQ6tqmQqMk8bjCOC/iOLkj1HdPq1CsiW4jPabN1Ht4+GBf6Yh2rpFHBji+Ofl
	 MBxds1cZUuwm6iQAz7tyjXKBJIS0WkmNBD+KRrSgPO1VrkKwcEwYKb9HihDY4c8+2OsW3
	 jAY+OlaXqowVekcX25JILbE8Dburk9m793wvSbrYF7O8zDVVUPOFetUGlVxD9Sdui4MWh
	 SeaFLjKOYrBRb47Szed3u80XtNw6Vn9ITKmmHqnfYxRCMXTppqSjcxked5cn4nl2lfR1N
	 Iv2xXqtejPXxMhY4dldvAzAbxYpRNVI0eksz78iRcj1EJRjwqR2txyurSqo8Yi1Ictg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793950072;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RiU0vB+DjypDljiTjrlfb3p7zcbiuIja3FDIwGVjII0=;
	b=KqCmmnjON/t9hJlubIr2LUgN6DNTQPPzRLTvyefhbJ0cFxygaRLkZYqorWQMy/lhAuLB
	 BO1HY+wlPPFLER7ig0/bvmejj68AQTVk9Co3xFSb0SULo6D+Kyunfe3SUDK5RA62rU3fi
	 aIFPWfy8UPeYN1g0Ey8ZJro62iTw6DP6sJjpi/BQklOo4mBPAnJkBlTmIRTEmBIc1UA4l
	 hTTIhvxovtAqagCJ1qFovCOl1nLOf6Yd4lf9Z7Gp0dgM42DJgl1Fgjgw+maj2altwLui7
	 Y34e7BMvIJUm6LaoFT7yArJFFyej/lXAqqnmZK+iNGoW9pvVCRA76KX7m3vbPrqJawA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=emlix.com;
	dkim=pass header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=LRaPqJ1l;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793950072;
	bh=RiU0vB+DjypDljiTjrlfb3p7zcbiuIja3FDIwGVjII0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WEYYqLpE/MAtGROPDMiYlQPOZtXm/fJURAd1uP6Lt2wk7zQKkjPIZ/XBxDXSO9dzx
	 IY2bykliOri2RSVhkehy2ub9CrGwOx7zbfcxWszE8RromunftxGP7SfehLOLJq1Y1c
	 uE6GLjdNyyliUAlNEchie5RRWZ7kTJ2NA0mbpc3SvdHjmhrQBsw3tsjYg7BjKDo4Z3
	 fuWDya32nZQj3J+nvFEjGgQewv97rvIHhCLOJoP+rEK/sKz8hNZBHZvI3SxhXsPbOX
	 Hx3UjvCymoAugYGBdzXKHd75L1rG9d8U9SLesqbM3ot+bqMikKNTXy8D5rRnDZFWAo
	 IMJGIc8ukE9Kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97F15605F7;
	Fri,  6 Nov 2026 07:27:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DC0262E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:27:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D8CD2605F7
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:27:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CN8STlP-b9Qx for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 07:27:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 57A17605E6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=178.63.209.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.63.209.131;
 helo=mx1.emlix.com; envelope-from=tkirchner@emlix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=emlix.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=LRaPqJ1l
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 57A17605E6
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
 s=20250930; t=1793950059;
 bh=RiU0vB+DjypDljiTjrlfb3p7zcbiuIja3FDIwGVjII0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LRaPqJ1luqmbg1020RfyZKV2BtNbeIGvQvreHlY/zA7fFaNrBWsngxn0LUHIRNHAr
 iW2Xi7pivB533rDWHK/3y5uycoGR4JRkDYQlNuGj7EDA+6WUGFjQwHcpmz8XerCyCx
 rHfh5GAqWT1qLaqJYylVSET4WSIaEdz7KCBbzavUGVMtpe9IkImEUZW5V5crik5GxD
 9LpgOkLknQyTRCxTkpwdQf9RQg9FOk05dGl6me4qqDlCffbjJ4p0JU9511AGDQFAHe
 C0d9H9IbcIZZJuiv4wgdxZQnx5CNQ79eKJHkJTw5aCKp+eYd/nFP/ZC6WEVapZkXT5
 kStrh0nVRcTiA==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id 1A2765F8C9;
 Fri, 06 Nov 2026 08:27:39 +0100 (CET)
From: Tycho Kirchner <tkirchner@emlix.com>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Eddie James <eajames@linux.ibm.com>, Tycho Kirchner <tkirchner@emlix.com>
Subject: [PATCH v3 1/5] tpm: check allocationSuccess of TPM2_PCR_Allocate
Date: Fri,  6 Nov 2026 08:27:25 +0100
Message-ID: <20261106072729.1714418-2-tkirchner@emlix.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106072729.1714418-1-tkirchner@emlix.com>
References: <20261106072729.1714418-1-tkirchner@emlix.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 1.4.3 at mx1.emlix.com
X-Virus-Status: Clean
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TPM2_PCR_Allocate may return TPM_RC_SUCCESS without performing the new
allocation, e.g. if the TPM lacks the memory for it. This is only
reported in the allocationSuccess field of the response, see the
TPM 2.0 Library Specification, Part 3: Commands, TPM2_PCR_Allocate.
U-Boot ignores this field, so a refused allocation goes unnoticed and
the board reboots into the unchanged allocation over and over again.

Check allocationSuccess and return an error if the TPM refused the
allocation.

Fixes: 9d2bc92ba7bb ("tpm: add TPM2_PCR_Allocate command")
Signed-off-by: Tycho Kirchner <tkirchner@emlix.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/tpm-v2.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 4c7dfc55650..137bbbd9593 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -596,6 +596,7 @@ u32 tpm2_send_pcr_allocate(struct udevice *dev, const char *pw,
 	};
 	u8 response[COMMAND_BUFFER_SIZE];
 	size_t response_len = COMMAND_BUFFER_SIZE;
+	u8 success;
 	u32 i;
 	int ret;
 
@@ -642,10 +643,25 @@ u32 tpm2_send_pcr_allocate(struct udevice *dev, const char *pw,
 	}
 
 	ret = tpm_sendrecv_command(dev, command_v2, response, &response_len);
-	if (!ret)
-		tpm_init(dev);
+	if (ret)
+		return ret;
+
+	/*
+	 * The TPM may refuse the new allocation without returning an error
+	 * code, e.g. if it lacks the memory for it. Check allocationSuccess,
+	 * located after the response header and the parameterSize field.
+	 */
+	if (unpack_byte_string(response, response_len, "b",
+			       TPM2_HDR_LEN + sizeof(u32), &success))
+		return TPM_LIB_ERROR;
+	if (success != TPMI_YES) {
+		log_err("TPM refused the PCR allocation\n");
+		return TPM_LIB_ERROR;
+	}
 
-	return ret;
+	tpm_init(dev);
+
+	return 0;
 }
 
 static int tpm2_get_num_pcr(struct udevice *dev, u32 *num_pcr)
-- 
2.47.3

