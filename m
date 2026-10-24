Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3550606A31B
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=W1tFTP+M;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=buKstwRp
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C006960743;
	Sat, 24 Oct 2026 22:36:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m5Z41ug_3vGI; Sat, 24 Oct 2026 22:36:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 00B3160656
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792881347;
	b=oN1JLyvqBETiCiz7sa4lAxmhPo4x/wgS+50/wc3Eqggzj+z8k+pfGmthMtyRUOCpR8Qe
	 gnMm3BnF+y8cDKWDaihXR6ThoWlEC7AEgm5m12cS8YV4ZxhuSGIvzRzIxbgmjUBT0KLv9
	 cxKbMBFZoG1ywAAZ01YU84lHTD8P1czPnlJcSKfJuBqBM0//cVBhMFaaLnAF/M9LswJvC
	 cvgcDn8ux/YIVMnmOElK6p2sILJQHGX6aZwTrrFZL3kOCVJqUK6cnaBTk0Z5IixJO0J3J
	 hPkY7qPbXSPleZyZRmJc8xbHIgQYmED6gP9StL/cnFNfGWqlYGM60MnYhinCc9CoqVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792881347;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=e6KnOxy5T/BgHIziQPdHEdwjkSCJ9cxRM1G0zKpy4Ik=;
	b=LSjaN1hM52Vc8UG6D2Aqbnog3Zi097aho1ZDMn/NXdJl80r/kSs8LahJxTjdmCvMaFR0
	 UCUwIn2ppFgL6mu/QOIvUfERMA4TYYj9PA/csu5hcgkBTOGKTRGUdmrvqiX0IiQkJuVu1
	 IMVpdydU/zAbhdZc/dyfDX7TS9lF5t0OzzJaKjvkyL/f3A4RjyHgrLR0+Je4HxXvriguj
	 Gbn8lv4Ivos6vAjsKhSl2E//9mjOlfnQISIt7ID05i9INpyzIMEqxJLOXLnnfKlaiou9Y
	 aMRbztWCFFz8U6MKCpF1gNEc1elzbQaqts+w1vtErMiMchrcfhDUDihQluWBPPRleQQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792881347;
	bh=e6KnOxy5T/BgHIziQPdHEdwjkSCJ9cxRM1G0zKpy4Ik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W1tFTP+MO1rcypajgiQiAHMDIoJBO0i586tGIbKSGxvU2Idu74bJ7A/XhQB23qc6L
	 rSXOjSQrfPOObJAPkrzl2+oReDK9Bol1x0kqzlTTONL1k0NxFmcxiGSZvHO1EsMVMg
	 kq+6GhYK3a/tNHisIIr/lgHTNkiyyCvNHT/c24tJLls5xEApQkkq10A2W8W52NForp
	 q1DEVDhCz22vg8YsYzJ99xgOgIlFK8/NTPYXigbLoUX3HRfsNH1Yl31oGDMy6IvXUc
	 axUP7LFemXA1Ewik1y0HytS3TEl+3VfXs3cHlTN4y2zgVKIp4ynnt1+zzKcQXvxgyI
	 BawE/nkBhKjgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00B3160656;
	Sat, 24 Oct 2026 22:35:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 25E053D9
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 23A7280E4E
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7lI1KUXw9_C6 for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 22:35:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 21A9280E3B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792881339;
 b=T5Kk+TN2+4OchprgL46IpWWzso5oNWsc0899KYe+pi0fRl2uPfT5k6/urhFdAHrwfwV3
 3f3AUg0zesYMOME4yxoEXla7m9xtVT58Cx0B1QJ5qYw7vTUVuNh7+S716wjj9x5sD+uRv
 WcFi8oKSlEU8R8xzqYA/L5TymdImKukTg2Y8ELw9lZ5p4KbItqhdPVCQwGqBKuhQ0Vm56
 ZpUc49/bpm62hQ9OhVN7qw8Ag41QQACTMsoUG6WTxBpa0Wcr++bEje65hnGwqwV0eCSid
 KgvLxlt7XIMheMVFtofhtMKbjh73h3nu+acmIBux/8GuAFNm8U2anP2msYxmfNT6qog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792881339;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=e6KnOxy5T/BgHIziQPdHEdwjkSCJ9cxRM1G0zKpy4Ik=;
 b=Fj8nmMr9Vdy5VAoAJyRIaO8I5Qo09jdPXbi3slF5Q+vEqKkM0cRmoaC+1NTSiAZ4Y2Af
 DWyeCTZ8GdJNCp5LYj3Wl7ai5rM9CQZD4G7xVFGnVvPrwDok//ofb2vtFVSc/FQv3iLhB
 PNnV+kxptKo1Dlkq43vqY8lev8XT6yCmqIlvkWXZcsJJPde5Vf9mw9J5WiU+v0Hu7sppC
 ZPX66HBtxA9PA5vMvT4CwenydkbedoTeqOXHjW2bE67TwhjrphMQQjOdXkJNYVn2TZpbR
 ut3iRxasnmmKEKS7HWiC9OLh+V8new2Mnq8srngtPx5Zs0p3qH50XhNHngFxD19cNNQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=buKstwRp; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=buKstwRp
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 21A9280E3B
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:38 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-82380b0f55dso830028a34.1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 15:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792881337; x=1793486137;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e6KnOxy5T/BgHIziQPdHEdwjkSCJ9cxRM1G0zKpy4Ik=;
 b=buKstwRpaAYeL0e2LFPJ/3IR7v9P4Gl/ekUNpcetWV29B0v06F6HAib+NNNFHIalk+
 z7t5XgpluMts9bEYnWvPltkJik1GoVDBQNDbFWMmbPzQZ63V1TwsSL0oswU6BZehdZNR
 nJo60nIIdI9eErvevqHBdOvcJtSR5tts3aY0qGhXfkufimcYwJxJZLVvyN4EmE0g2gVH
 wH6Hqqy/scccZ+WyDAvqgPgilLT2xI5zbNJumApUFaBp2/z/evl0ugWPqGqbpJ+BNjeF
 8oM7R8d9dyURLAlaQ9/gji23YkR9E6EJP0QadsAKZzE1wLPRvqZLSbvabahqTNJx8503
 oGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792881337; x=1793486137;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e6KnOxy5T/BgHIziQPdHEdwjkSCJ9cxRM1G0zKpy4Ik=;
 b=dsNyYvZG2DUSDiEFGrNu3T0wBf1TDJw8GKY93Pue2Lwhr0Sy8ZAgPxgebtHr4lNNRr
 qMx/HsOlmJSEigGcvuOeNlDAbTT24kTyH29Fj+75AwoPs6IfSgzQjTVXyv8l4L4tzJE1
 sc2W4fcJeDoQcDz+7gFhy0NgPwgSGGDgEC3S322botp98ADTmMlx8FePTuk7uz4UBIZ9
 2QHOw7Q4pkoUnOpH6CGzzwXCxOREqx5B8SjKJNL+CcEIYes041PXlhw9+5bKwKK908IY
 sEYHwUITL5TlhM/HuWIYOnv0p8/1sWiWaUhD7XpstL8pOR1XKuRLZAK9Iugz8xzFhbzu
 X3Mg==
X-Gm-Message-State: AFq9FYKu7wOyuKIZioYV+ScUyObouxvT+etmh/mtdmP5XZnBIsgv/GgW
 Du+TWLAFUkh0bkXpbPxO6Y8SAEO10TjZZK76xEJzri3yTd99mygIjINy
X-Gm-Gg: AYBFou2phT5QjwTtPfK+4dYFSu4ko4K2ppAHQU3m0QOJRtq9E+jKtW8Cxpv82bQEKok
 nivacsYwNBMl550kObrlgo/L0xUBr/9/maA1bUUTbT3Xp+rtZDCtH2YFsmycosQNvHaQJeAMiM5
 fJJ3PbZbIn8S1kpLb/5S96+mRq4pjBlnZ108/edBpSie1JqSoNcwiemOH8wLY8Yc4Izy+/FeMph
 1QJn72kGRXx4onheffCj4h5bvsaPIu5kHywpdznydKgqC0B8V0twaqmEJpvcfBkWgjpnVwDxVQZ
 r+zgmWeS4wqDYpJzJxtLo4lR2+0HShg5bAfSKs92WAMDt2tj7zj+tU3nBPaI/dS2vN1y4oj+iOk
 C5zMHyJIepOoeUHQTXCNMUApSrp3Wlgo4rcphmcF5/DyBaXh5WMugS/i/mFqYbRCL75Ap7WbfEF
 d3SR7CyOIfUNB9b/0Qx/kAQydd8HRbrDQPrwZ9eQJmvvi/ju2q3vW8dKU05hsm3VwRX4otzOgZ5
 ug+XNAbhO6lLzid5PN1WBxsouk+8hPaWq357+9uulp22QgmzX7CcVVTxhxOB1qa64nqA+KANKG8
 5cEgWy7yTjiXnYQySeByDkcXObOCwsFG7qcX39I0VEeZzMoz5lyhndrlTE0SBnHy7Pa7vnvg+Kx
 ksd76fY/vogLbaPhI6ogZAvqrG9NCaPCTWJG2qzkWXWcfrlSvWeHAhG+TcsCrlPoBTqdQ5mfOdA
 /zAWEJ
X-Received: by 2002:a05:6870:56aa:b0:45e:54a3:b8ca with SMTP id
 586e51a60fabf-4a83f43eef1mr1795890fac.19.1792881337415; 
 Sat, 24 Oct 2026 15:35:37 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8430d8130sm1706457fac.5.2026.10.24.15.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 15:35:36 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 16:35:00 -0600
Subject: [PATCH v2 13/16] net: lwip: use the selected interface for TFTP
 addressing
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-submit-lwip-tftp-combined-v1-v2-13-0f663f735ee8@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Validate and report the selected interface's IPv4 address instead of
the global ipaddr variable. Derive automatic filenames after the
interface has been selected; indexed interfaces may use ipaddrN.
Keep explicitly supplied filenames unchanged.

Accept physical address zero for client and receive-server transfers
when the target memory layout permits it. Retain the existing range
and memory reservation checks.

Exercise indexed interface addresses, invalid addresses and transfers
at address zero with the sandbox command fixture.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 net/lwip/tftp.c | 75 +++++++++++++++++++++------------------------------
 test/dm/tftp.c  | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 112 insertions(+), 46 deletions(-)

diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index f29a20f518e..41ea12ed486 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -55,6 +55,16 @@ struct tftp_ctx {
  */
 static struct tftp_ctx *tftpsrv_active_ctx;
 
+static int tftp_check_ip(struct net_lwip_ctx *net)
+{
+	if (ip4_addr_isany_val(*netif_ip4_addr(net->netif))) {
+		log_err("error: IP address for %s has to be set\n", net->dev->name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * store_block() - copy received data
  *
@@ -346,7 +356,7 @@ static int tftp_loop(struct net_lwip_ctx *net,
 	u16 blksize;
 	err_t err;
 
-	if (!fname || !*fname || !addr)
+	if (!fname || !*fname)
 		return -EINVAL;
 	if (operation == TFTP_UPLOAD &&
 	    (size > U32_MAX || addr + size < addr))
@@ -373,9 +383,9 @@ static int tftp_loop(struct net_lwip_ctx *net,
 	net_boot_file_size = 0;
 
 	printf("Using %s device\n", net->dev->name);
-	printf("TFTP %s server %s; our IP address is %s\n",
+	printf("TFTP %s server %s; our IP address is %pI4\n",
 	       ctx.upload ? "to" : "from", ipaddr_ntoa(&srvip),
-	       env_get("ipaddr"));
+	       &netif_ip4_addr(net->netif)->addr);
 	printf("Filename '%s'.\n", fname);
 	if (ctx.upload) {
 		printf("Save address: 0x%lx\n", ctx.daddr);
@@ -475,18 +485,11 @@ static void no_request(void *arg)
 static int tftpsrv_loop(struct net_lwip_ctx *net, ulong addr)
 {
 	struct tftp_ctx ctx;
-	const char *ipaddr;
 	int ret = -1;
 	err_t err;
 
-	if (addr == 0)
-		return -1;
-
-	ipaddr = env_get("ipaddr");
-	if (!ipaddr || !*ipaddr) {
-		log_err("error: ipaddr has to be set\n");
+	if (tftp_check_ip(net))
 		return -1;
-	}
 
 	memset(&ctx, 0, sizeof(ctx));
 	ctx.done = NOT_DONE;
@@ -495,7 +498,8 @@ static int tftpsrv_loop(struct net_lwip_ctx *net, ulong addr)
 	net_boot_file_size = 0;
 
 	printf("Using %s device\n", net->dev->name);
-	printf("Listening for TFTP transfer on %s\n", ipaddr);
+	printf("Listening for TFTP transfer on %pI4\n",
+	       &netif_ip4_addr(net->netif)->addr);
 	printf("Load address: 0x%lx\n", ctx.daddr);
 
 	tftpsrv_active_ctx = &ctx;
@@ -563,12 +567,6 @@ int do_tftpsrv(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		goto out;
 	}
 
-	if (!laddr) {
-		log_err("error: no load address\n");
-		ret = CMD_RET_FAILURE;
-		goto out;
-	}
-
 	if (net_lwip_start(&net, NET_LWIP_ADDR_ENV_STRICT)) {
 		ret = CMD_RET_FAILURE;
 		goto out;
@@ -586,22 +584,14 @@ out:
 	return bootm_maybe_autostart(cmdtp, argv[0]);
 }
 
-static int tftp_default_filename(char *fname, size_t size)
+static void tftp_default_filename(struct net_lwip_ctx *net, char *fname,
+				  size_t size)
 {
-	const char *ipaddr = env_get("ipaddr");
-	ip_addr_t addr;
-
-	if (!ipaddr || !ipaddr_aton(ipaddr, &addr)) {
-		log_err("error: ipaddr has to be set\n");
-		return -EINVAL;
-	}
+	const ip4_addr_t *addr = netif_ip4_addr(net->netif);
 
 	snprintf(fname, size, "%02X%02X%02X%02X.img",
-		 ip4_addr1(ip_2_ip4(&addr)), ip4_addr2(ip_2_ip4(&addr)),
-		 ip4_addr3(ip_2_ip4(&addr)), ip4_addr4(ip_2_ip4(&addr)));
+		 ip4_addr1(addr), ip4_addr2(addr), ip4_addr3(addr), ip4_addr4(addr));
 	printf("*** Warning: no boot file name; using '%s'\n", fname);
-
-	return 0;
 }
 
 static int do_tftp(struct cmd_tbl *cmdtp, int flag, int argc,
@@ -764,26 +754,12 @@ static int do_tftp(struct cmd_tbl *cmdtp, int flag, int argc,
 		goto out;
 	}
 
-	if (!fname || !*fname) {
-		if (tftp_default_filename(default_fname,
-					  sizeof(default_fname))) {
-			ret = CMD_RET_FAILURE;
-			goto out;
-		}
-		fname = default_fname;
-	}
-	if (strlen(fname) > TFTP_MAX_FILENAME_LEN) {
+	if (fname && strlen(fname) > TFTP_MAX_FILENAME_LEN) {
 		log_err("error: TFTP file name is too long\n");
 		ret = CMD_RET_FAILURE;
 		goto out;
 	}
 
-	if (!laddr) {
-		log_err("error: no load address\n");
-		ret = CMD_RET_FAILURE;
-		goto out;
-	}
-
 	if (operation == TFTP_UPLOAD &&
 	    (size > U32_MAX || laddr + size < laddr)) {
 		log_err("error: TFTP upload range is too large\n");
@@ -796,6 +772,15 @@ static int do_tftp(struct cmd_tbl *cmdtp, int flag, int argc,
 		goto out;
 	}
 
+	if (tftp_check_ip(&net)) {
+		ret = CMD_RET_FAILURE;
+		goto out;
+	}
+	if (!fname || !*fname) {
+		tftp_default_filename(&net, default_fname, sizeof(default_fname));
+		fname = default_fname;
+	}
+
 	if (tftp_loop(&net, operation, laddr, size, fname, srvip,
 		      port, srcport, timeout_msecs, max_retries) < 0)
 		ret = CMD_RET_FAILURE;
diff --git a/test/dm/tftp.c b/test/dm/tftp.c
index 45612e066e5..62a0a887150 100644
--- a/test/dm/tftp.c
+++ b/test/dm/tftp.c
@@ -47,6 +47,7 @@ struct tftp_test_context {
 	ulong ack_delay;
 	unsigned int advertised_timeout;
 	char filename[64];
+	struct in_addr local_ip;
 	u16 blocksize;
 	u16 windowsize;
 	u16 port;
@@ -148,6 +149,7 @@ static int tftp_test_tx_handler(struct udevice *dev, void *packet,
 		if (!ctx->requests++)
 			ctx->request_start = get_timer(0);
 		strlcpy(ctx->filename, (char *)(ip + 1) + 2, sizeof(ctx->filename));
+		ctx->local_ip = ip->ip_src;
 		ctx->blocksize = tftp_test_option((char *)(ip + 1), request_len, "blksize");
 		ctx->windowsize = tftp_test_option((char *)(ip + 1), request_len, "windowsize");
 		ctx->port = ntohs(ip->udp_dst);
@@ -439,6 +441,79 @@ static int tftp_test_protected_autostart(struct unit_test_state *uts,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_NET_LWIP)
+static int tftp_test_addresses(struct unit_test_state *uts,
+			       struct tftp_test_context *ctx)
+{
+	int i, put, ret;
+
+	ut_assertok(env_set("autostart", "no"));
+	ut_assertok(env_set("ethrotate", "no"));
+	ut_assertok(env_set("ethact", "eth@10003000"));
+	ut_assertok(env_set("ipaddr5", "1.1.2.4"));
+	ut_assertok(env_set("netmask5", "255.255.255.0"));
+	ut_assertok(env_set("bootfile", NULL));
+	ut_assertok(env_set("ipaddr", NULL));
+	for (put = 0; put <= IS_ENABLED(CONFIG_CMD_TFTPPUT); put++) {
+		memset(ctx, 0, sizeof(*ctx));
+		ut_assertok(run_command(put ? "tftpput 2000000 20" : "tftpboot 2000000", 0));
+		ut_asserteq(1, ctx->requests);
+		ut_asserteq_str("01010204.img", ctx->filename);
+		ut_asserteq(string_to_ip("1.1.2.4").s_addr, ctx->local_ip.s_addr);
+	}
+	/* A valid global address must not hide an unset/invalid indexed one. */
+	ut_assertok(env_set("ipaddr", "1.1.2.3"));
+	for (i = 0; i < 2; i++) {
+		ut_assertok(env_set("ipaddr5", i ? "invalid" : NULL));
+		memset(ctx, 0, sizeof(*ctx));
+		ret = run_command("tftpboot 2000000 explicit.bin", 0);
+		ut_asserteq(CMD_RET_FAILURE, ret);
+		ut_asserteq(0, ctx->requests);
+		ut_asserteq(0, net_boot_file_size);
+	}
+	ut_assertok(env_set("ethact", "eth@10002000"));
+	ut_assertok(env_set("ethrotate", NULL));
+	return 0;
+}
+#endif
+
+static int tftp_test_zero_address(struct unit_test_state *uts,
+				  struct tftp_test_context *ctx)
+{
+	static const char * const commands[] = { "tftpboot 0 file", "tftpboot 0", "tftpboot" };
+	void *buffer = map_sysmem(0, sizeof(tftp_test_data));
+	u8 saved[sizeof(tftp_test_data)];
+	u8 received[sizeof(tftp_test_data)];
+	int i, ret;
+
+	ut_assertok(env_set("autostart", "no"));
+	ut_assertok(env_set("loadaddr", "0"));
+	ut_assertok(env_set("bootfile", "file"));
+	for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		memcpy(saved, buffer, sizeof(saved));
+		memset(ctx, 0, sizeof(*ctx));
+		ret = run_command(commands[i], 0);
+		/* Restore sandbox RAM even if the command failed. */
+		memcpy(received, buffer, sizeof(received));
+		memcpy(buffer, saved, sizeof(saved));
+		ut_assertok(ret);
+		ut_asserteq(1, ctx->requests);
+		ut_asserteq(0, image_load_addr);
+		ut_asserteq(0, env_get_hex("fileaddr", 1));
+		ut_asserteq_mem(tftp_test_data, received, sizeof(received));
+	}
+	if (IS_ENABLED(CONFIG_NET_LWIP) && IS_ENABLED(CONFIG_CMD_TFTPPUT)) {
+		memset(ctx, 0, sizeof(*ctx));
+		ut_assertok(run_command("tftpput 0 20 file", 0));
+		ut_asserteq(1, ctx->requests);
+		ut_asserteq(32, net_boot_file_size);
+	}
+	unmap_sysmem(buffer);
+	ut_assertok(env_set("loadaddr", "2000000"));
+	image_load_addr = TFTP_TEST_ADDR;
+	return 0;
+}
+
 static int tftp_test_download(struct unit_test_state *uts,
 			      struct tftp_test_context *ctx)
 {
@@ -463,9 +538,11 @@ static int tftp_test_download(struct unit_test_state *uts,
 	ut_assertok(tftp_test_protected_autostart(uts, ctx));
 
 #if IS_ENABLED(CONFIG_NET_LWIP)
+	ut_assertok(tftp_test_addresses(uts, ctx));
 	ut_assertok(tftp_test_options(uts, ctx));
 #endif
 	ut_assertok(tftp_test_filenames(uts, ctx));
+	ut_assertok(tftp_test_zero_address(uts, ctx));
 
 	/* A previous DHCP/download must not override the next command's env. */
 	ut_assertok(env_set("autostart", "no"));
@@ -616,7 +693,7 @@ static int dm_test_tftp_download_only(struct unit_test_state *uts)
 		"ipaddr", "serverip", "netmask", "gatewayip", "netretry", "tftpsrcp",
 		"tftpdstp", "tftpserverip", "fileaddr", "filesize",
 		"bootaddr", "loadaddr", "bootfile", "ethrotate", ".flags",
-		"tftpblocksize", "tftpwindowsize",
+		"tftpblocksize", "tftpwindowsize", "ipaddr5", "netmask5",
 	};
 	char saved_bootfile[sizeof(net_boot_file_name)];
 	ulong saved_load_addr = image_load_addr;
@@ -637,9 +714,13 @@ static int dm_test_tftp_download_only(struct unit_test_state *uts)
 
 	sandbox_eth_set_tx_handler(0, tftp_test_tx_handler);
 	sandbox_eth_set_priv(0, &ctx);
+	sandbox_eth_set_tx_handler(1, tftp_test_tx_handler);
+	sandbox_eth_set_priv(1, &ctx);
 	ret = tftp_test_download(uts, &ctx);
 	sandbox_eth_set_tx_handler(0, NULL);
 	sandbox_eth_set_priv(0, NULL);
+	sandbox_eth_set_tx_handler(1, NULL);
+	sandbox_eth_set_priv(1, NULL);
 	image_load_addr = saved_load_addr;
 	memcpy(net_boot_file_name, saved_bootfile, sizeof(saved_bootfile));
 	for (i = 0; i < ARRAY_SIZE(vars); i++) {

-- 
2.53.0

