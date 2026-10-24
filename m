Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26116606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GzZl95/U;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DcAWMqbq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 05871406C3;
	Sat, 24 Oct 2026 22:35:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oJ-ov3WU89bB; Sat, 24 Oct 2026 22:35:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 42BD84069A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792881333;
	b=eY+90a+P+fgPFgFjX5iwyrZWccIqDbqZGwCy/hVujuoxjM0AZtUJ9NllcRg9glnFmPB+
	 hSvSu0phjNlr7famuYX+7QkRefvdmRg8+Laj9/Rd3Zt1gpbuuJ+VjnY0kRMrWpRsUzj/y
	 kItX2Ql+7b/nTH8pgVOxhjmSA07dhf9oRc0FNHhn/iz8IfeNWM82o1ntMXVGTzvOdLrhS
	 OXY42SSrY5iNcnzQfn6BUxEOaxuJ77LFMUmrXOMkMtCtE6VeCuRDmhwfMN3l+MEtpPA3N
	 ojrwpsdPVpjqmlFTNzJ9rgzfbf3bt0N+NdY8hmjXliCLAsrCP1nBNHTNngenReTPahg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792881333;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/QVi+8qWXjyx0VATDiUf+D29zE5oeA71btQBds2S/+Y=;
	b=PvquuDuronwrGPo7auEiZ1Rd6LPbBYX+i/l3WuUaj2kRqRgIF81uySknUj59Cp0OUj9f
	 nfugoYQpjPYFKof/D5wVX1DUB5iIEMjWa99+Jy0Hvk++5+n+mg4PCNwwNHpF//LM3M3iS
	 xhMq9Gf/WvOJvKhTubdB1GZqH4uqxjHNZJ+HU6I0/gDEj5PLqDNCIitxsDjZYAawzRZ5d
	 k87LVYs8AkfzNYM7oBnRYBSHJucpNgiCkLFzj6lDPTr2sFNMgRehzibwmJ62MC978BPy2
	 1oA+rVvMgD/7t75E6z9tOjAjqi39H66k3LNqbBwq7N4bPE/ysF8NzEC+iaj3Qi2PWxw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792881333;
	bh=/QVi+8qWXjyx0VATDiUf+D29zE5oeA71btQBds2S/+Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GzZl95/UeaMz9QQuKAp2PqxZ7o9K64u/6MnNs0NWKPXaPlRtjU5ii7J78iRXEL1+A
	 cJ/9daxDPBwdS40Keaql7U5I/vsB9P3quuyPskoWdU5mJJwkV7c7YNhFcHFCcYCMKp
	 BdkwKqq5q7CnzCIyL//W2j0Cxp1dre2UNXFX3cBSGQ4OPBvFWrpIfPNKmezWuDd3y7
	 AjGDyXJLr4CAGPlz7x47BKZYkqBjgnwHhARvt+KFsljcLWapJPNHGnGZEtsl3U6NeC
	 fP4sP/snIpDoZmMesEghh6eduzCGaBuhVwfxaDAbukx7g9Xw2hzcsyxDtikylDoj1h
	 YiA+1cd+KOh4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42BD84069A;
	Sat, 24 Oct 2026 22:35:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 872AA765
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7648E80F34
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wvgAuLs13DaV for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 22:35:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C02BB80E4E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::34"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792881326;
 b=LJy6mddBEEGwYnGkmXpO2M6sX3xIYXg2O9WvKtjROY2/tvsNYh2Hctf+4Ur1RFsv1LLo
 i47YvwjWAYjtyl5yasQbgD1mgqjddsLH17EOS718HmQVbeY0dxCU3CpPf0kmxGB9j7jGJ
 p4b87eMERaE4h7rbUZqtfPEV1OdOq4p9ChPWE5QBJ9NkfCHVxpXulB0GEUNfAhJQArSiW
 2yzcPkWKBaoz250tXnYhs0pOi0v4lznIQDsd3rBBAMaZWgr/vj9F+odu42bLHa3Do8foV
 DB+y2acEVLXjU0EUOi3YRUU50gB/S4JpiDRpjPaQBQNGrv/u1UJG96FXfwy2f6TKB8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792881326;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=/QVi+8qWXjyx0VATDiUf+D29zE5oeA71btQBds2S/+Y=;
 b=XZv4Zt4qHfsu4m9jmlFJqetue8zWVnk3mq3F0r5Lk61f3ra2FDtQ97NaEhAN2rc3eXMd
 u4VpO5rzGZy2IB1lvGndIuWBHR+87ddimhCxhSGjYjeVgxSXVRh/+N5AzrmuwWtxhY7m5
 kjAd2J/GFb1HG9sOrpIuazx8ji/6P8RLCUapLyELSptQutMU0vh5/yG60FdN0/PFZkTWo
 1WZKMRZGwvabHqjVoR9ldVDZ3/8d0d7Mgkjf1W+8AUJNvIk+tW2IyumZaIQjJino5zV9Z
 QYInnAheJsawlPEWkQWMHKSdvtA1l0v9+/PJAjT5hMYMqylqSJjiB/qHR2FdKSVlDtA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DcAWMqbq; 
 arc=none smtp.remote-ip="2001:4860:4864:20::34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::34; helo=mail-oa1-x34.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=DcAWMqbq
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C02BB80E4E
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:26 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-451a49abd8aso1867853fac.3
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 15:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792881325; x=1793486125;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/QVi+8qWXjyx0VATDiUf+D29zE5oeA71btQBds2S/+Y=;
 b=DcAWMqbqdJq3AFOMHTKg2U0c6HvbFmaZ63W/fBoilFlKb3IqonXfAes6txeli5Zeh1
 np9VEiz2W+Lpu66hl9giO1K04AtQqkm9ZW2xVPwYCVFLydAtC0IqzIEvbKbemT4KFHK/
 xHrCmn1pPjFNTq2DziUzpAKWcJi62H2VYCRseBxhODRPn71y0Wr84/T44ccPQdaClOsF
 YqDKmDHc2QVBmnQVdWvBp4VtJVFBd7doe7U11ZaWLXCQpkp5aoq4fj+/Syo9bp+p/Ap5
 5dcdiByBWSzzyx8nb55UnuPvFeEh5zxejQHlfiIwF5oa6wYdImsPPATcvZURtU63zGc7
 AhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792881325; x=1793486125;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/QVi+8qWXjyx0VATDiUf+D29zE5oeA71btQBds2S/+Y=;
 b=coYMAtQWG4P7FG+KurL4ffYxmJXilT+rTj7qNI8L+wBjV1/JP9FSWruvFHNoT1cbjv
 95ngHvWX7Qdi+H7B0bhkpZFIu5cyepZD1IPOwUCtVZyYk2y8kLExftwwSnGRU2sEPw6o
 gtZ8uaEnnVEY2bSOUXF3FdH+4SAotdFM8eZk9ieIT8l+eAPejxKoANFr8+jaNQglw4kX
 Q1tFyww2dTJ/E0uKpur0Jthwhj3xA1SA5WxiOPyQsyJOCcYjez635kZgvBfZ0UhmPLgZ
 omLWW1vtw5CL48vyAAKiXYE42SO17HKymwJHEfOChEzUZ/4I/W5xEmXXdhOXMsuwJJ2Q
 YLvA==
X-Gm-Message-State: AFq9FYKQOknC687p64OniQFCxMowgaylYZlJVWDwp1d5h6SZqVvdmVcH
 aTwq8dkFzM6U8XR5OZLcyk3/v6Ypxyl2FwmFqIn1skLUD/aoCdu/MDgV
X-Gm-Gg: AYBFou0o9zyKN3wJnbOcqpphsGbcXy3bGzkaz/ia9FdkcHvS45LgaT9iBAhWhXfpFvq
 fVmFAt+Cd/78u1CfbXtiy1SzOVZdzRcgvWwZezueiFcQgaExKcpeD/XYkVdW+7o7CJ0E6yR1nq6
 ZkKH/5ukCOuIa5aRLOq5Frf4B+5NaLy+e1YCn/sM4+jCn3UEEDVGUdvF34Wh7omaaUWIForiIUX
 qCCxELbK5qMQiE9becNq920obAK4rtpXOsvBLVkUQSfgP2v+rqXqb8rll6OdL9bNNY3RNQk7WYH
 aZ+4ChtyTZ5+q2CBu4i47CtteCwLNvc5DN2utflLwotwjr9vVSTqqXOvdS1un6LnevCc4voreC1
 k5rwvkWVexmhqFGPQVNgTQkIUE35A6ZtlujQinY+5e2m0PVbZiD/+oPUMSF8Cn3ARbPHCkdhlZ3
 9k5ceFUqbR5gYu9rLX0RE6GfHIbFS5aFmL/+Fu0wHlh2KoDKAfEn/1WAQ25qx5rLgQuYLKKUU2R
 wraClo7a6ZMRlLFg+oQLnqRKf4GVp2/Riu/DWn9hKb6RO1XclZVyFZaah+1Pc++bvEdVV0YuMqe
 TMCKJe00ZCFD449UJWuLwaclZn7msM+6pcW7R/07jspeUpdOxKI8nhjWn4cvlC3Sp2aJO+0h/1l
 VAK9ynXBsR0XF5ZOZ1w0yKZz+dOX5FvJ9k1ZipUoFORcQUCorTO6rvnrnD5qrIhqloaOQbCeACT
 3Gi8E=
X-Received: by 2002:a05:6870:6120:b0:494:8d38:437b with SMTP id
 586e51a60fabf-4a83f4c711emr1694902fac.37.1792881325645; 
 Sat, 24 Oct 2026 15:35:25 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8430d8130sm1706457fac.5.2026.10.24.15.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 15:35:24 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 16:34:53 -0600
Subject: [PATCH v2 06/16] dfu: enable TFTP transport with lwIP
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-submit-lwip-tftp-combined-v1-v2-6-0f663f735ee8@gmail.com>
References: <20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com>
In-Reply-To: <20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, Pranav Sanwal <pranav.sanwal@amd.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Drew Kluemke <ankluemk@microsoft.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DFU-over-TFTP uses update_tftp(), which now dispatches through
the stack-independent TFTP helper and no longer depends on legacy
networking internals.

Allow DFU_TFTP with either network stack and select the network
commands required by the update path.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dfu/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
index eeae2fd65ad..1cc2595eb01 100644
--- a/drivers/dfu/Kconfig
+++ b/drivers/dfu/Kconfig
@@ -11,7 +11,7 @@ config DFU_OVER_USB
 
 config DFU_OVER_TFTP
 	bool
-	depends on NET_LEGACY
+	depends on NET
 
 config DFU_WRITE_ALT
 	bool
@@ -20,9 +20,10 @@ if DFU
 config DFU_TFTP
 	bool "DFU via TFTP"
 	depends on NETDEVICES
-	depends on !NET_LWIP
 	select UPDATE_COMMON
 	select DFU_OVER_TFTP
+	select CMD_NET
+	select CMD_TFTPBOOT
 	help
 	  This option allows performing update of DFU-managed medium with data
 	  sent via TFTP boot.

-- 
2.53.0

