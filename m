Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598EB606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AymSS1ny;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VUFq4+uO
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 064ED813AB;
	Wed, 28 Oct 2026 14:50:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wNJ8WIPLN1K5; Wed, 28 Oct 2026 14:50:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9FD1C813EE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198933;
	b=oJO5O5akET4I4oxssQmrjgDoj4ThPtDk/Au3v6/s0VqOQsRVf0STvsPg7GzEio5NQ+FB
	 ikrcOSB04g3/t+9FlAuUbIHelJlM8r/ieNaq5jzIueOL3vytMcZEDz3jGaoTJWdgFYDiJ
	 8MRnxwg9092EnS/KIPT+wCVXumrUfTt7iWt8KYC9AjCnk48XcWxbR2O3mixbtuIVjf/xV
	 UzpRJdyd/eyzmY6E/z0x59yRG8Vp3iJR9rjSvz/pQ9g0lYj8dHEovImQ0SvDzzu4fEZy9
	 JBMGfZ9ikCdOXSAeD/EvBehw2oWPkqnG0OO0L2f231wwQJ/1JRk2Phjy/FbAXert6Fw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198933;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/XWSC8MTlEiQv9sydP6YP1Yc3LJ+Cph2PrN0/OFhESA=;
	b=qStp5tk6dX6LC0dvjXyN0i/nPPlHJMGB+ZQcR1XcOQeSKd++9fT3AYdL58IvnzDr24qy
	 CCshDMeIRWgUWOUuW9j1TXXH/Q9rByryC8lEPLRKnJfiH70k2Nlwv7nDtf1Gzl3GGqV7A
	 F97uRGTWXplt74ao+2hxno+LiCsXPLybVz/rqCOGC0QZXP5oC57OSXh4+9cmRRh+QKJCK
	 LQtxb8c/OYZljvD9wyUI4Sr8WlFBlyb4sLou8+J1ItZ0zuqP5fI4FqDYkvRlcPiYVg9ZS
	 nNLhKpwtkR0+K7dj2b8nxp0sAt5T+SjNVzrjFA4/0b+Efo8NPAM2OqMNZgYyfH3z6sA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198932;
	bh=/XWSC8MTlEiQv9sydP6YP1Yc3LJ+Cph2PrN0/OFhESA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AymSS1nyeB3R/UiDFVQtDwyOUJLGNNlfQNM1HjyyWtN7AxQOYAx2+3x+xEyyqolwo
	 khhGcDwQJ2sBP5hfIY1ogZtVlEz5HwnBuh1yub9wwXWYj22e7NUvYMs0+rJYsTdI/J
	 +JjL6P46U44ILe5V/Ye6x/45zuZ6Z2E58dZfPWpVaVNRYbG6W6oE45hb/7wJ0Yh/q0
	 HDnvQXESRw3puKAxtJFJ/Wn4t0EaLvDAvvF6bqyCKxZj5pYuLvje9njyfdYKrOH+Zc
	 ghf4R2QV4Cv7hxaPgrvQtvlXf196iX9msi6wF0vmhkY6ZsrIhSpoQ07Ch4Bu8w84Hc
	 Ysdeficb/T1xw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9FD1C813EE;
	Wed, 28 Oct 2026 14:48:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 92A224D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 78ABF4009E
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZEXCXF8mlCu0 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:17:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8A6564008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::636"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793197074;
 b=atmcrpdw+VPWrJxH4cHeFG+sKowsdzc6oyFlQFv8irNjCiBWx0aWjvjDTxw4nzydVxVV
 GSAQ3cwNcJPCarN79PnnhS3aorKxOcs9LSf/uP6eVHxChWC93UH33Iya3bW45s4nZSF8A
 5MJzjE5XmDgBEVLVcTHxlc/uyprGCWSx/7Q3cpOgqOxFrK4CXmZ3Cqfl3QUG7j3AT/E8i
 BCfulGfNTxKOVIaMh0h8kmlso3JizJ0Fb0F5T/ir6GQP+wHKQNwSB1mmxXPJ1+W3tuP2w
 xe5nzOO0QoNMv6tZwm8xW8Aiglk1FNtf8zLBDYG6jrdqgy5BNtgC6ph5D/tqn9FCI2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793197074;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=/XWSC8MTlEiQv9sydP6YP1Yc3LJ+Cph2PrN0/OFhESA=;
 b=qu+9a3W7U8HQ3nom/O5EczXQjx3y0k5sSATDvmVq1OxTqsujCS/hyZ3V7C3AVoQlc9UL
 OI7BGNB0tfsGNhX5n1RnQVtx3DJ0zTaGFEKxx0+WqZJprB2lEtj3F9rzjYtsuznqYipCP
 5/zWLHd/+jVrALCzt8o6iHjoBSsZddHf99Lw4017HEDRbMCb5mWUZXc6QzD0ynnWcQnpN
 eWDzNWr0V4zSyB06hD/h5F8CUvhNbuE8Z8edu/Ntux57J4bVYH/V7n6DbvM619i1qAh09
 0J1L278mTNY3ZMKunpbfI51xkz5+mSXkcfBeMWyUJ6QKM8N64ttdXdX6AiJDO4192JQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=VUFq4+uO; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::636"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=VUFq4+uO
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8A6564008A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:53 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c407213696aso10491066b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793197072; x=1793801872;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/XWSC8MTlEiQv9sydP6YP1Yc3LJ+Cph2PrN0/OFhESA=;
 b=VUFq4+uOam1Qh4tGhWswdzn+wz4NRycoC2BeF39qisbOYe8HV1Cu+D4uA/ZnVb9vzb
 LbkrllVEu5GnYMvfCxz19xdFTtN+CVbSAfDAa5SFLNb7UHPT3enWIfoekigsHAcrKRH6
 6aKjXgqs2fLpvutPjyqX008IaR9J6IHYn1/dI0ZguNQ+nAKCwOOURPB3sViwPbzkkL6x
 yeVTSNU0OcWLHJ3W4kQ5M3lZzKgkhPvhJdfeehWSQzec7mjnEWk+TkOLB5Nxf2auR5Kd
 HVGo6gCN2lTM3QxVeLhv0di7VH9KmA4KrlRSSA9ZkNR3h3vqCNY+5UzymYTsIi8s3lZ6
 jl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197072; x=1793801872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/XWSC8MTlEiQv9sydP6YP1Yc3LJ+Cph2PrN0/OFhESA=;
 b=EYbpsqBznZ8AjqjP2XgTfbxlOIvS5qRmfgao6jP0PB4rF/3s0+jMjLUWb7SpJFglKs
 f3WRndBA5BfYnSe3U33tIxrra8JdDCEBpsDUp7hEY6i5cbnSqkoynwj+cRvHRHEJpiiu
 J/7Eh9hPZnVsoTCUIRJFqupmGOOvJ7h2cdVx9eZ2q64FUOvdWuPsMIBwa88riq67LQSZ
 t2mkSWINQyUZuIQDXa+TX2srlGA4rJm8S6tCxNM/lyLJlS19qlLi3WY7q2TFXIlNs2P6
 i+H/8BcObf6KFqxM7sn3lr/Hn8V09XT+HfpILmtF0N9qBLltCWke9s3S+CdvENOh5lIL
 k0AA==
X-Gm-Message-State: AFq9FYL1Yna4uw2lECbGZ2ggbOZP6HBB0lsWrhzubxv5ZctFdhvogjTT
 rM/RfgQga6gR5Esh+I2qQc2bydME39JtfDOedlf1+1Y9+ZUu/hDk7lnpmYXWdz8zwQcAzQAE8Vh
 mkv52
X-Gm-Gg: AYBFou3NGVovsIX0Ka3z9luDiNBknykK4hNn3eUeQo4wzRE4z743p8m+4jUr+aam5yF
 8sLSXGsO221nvtFzNnZ73fFOmJn7PoVSFkpeJhH56+5+la8ST2kkeETc3VVDYBFm/1QIQIryn23
 2JHyt8j4vGpp2Sq4GT+qs4TSXWlWl4jr2L9BRzNdAKIt8+WoEPg8iUCJPhksla8guwdwVRAnjIJ
 8SAnVzmOD3r318F4O5gRagOQjK9Ch6JUn4sOawvBljMLw2yCf1lsMrUqHIuhG1ZMCnUKp1y7msO
 NLvkE2KS2MUvV3yK4AWtNor+q7fKmg2Q5Zn/1mPhoQF2NEg1GLbrYwyVKjhdMYkv/Hv6B1SFj3k
 jvpUV1z1iL89oQtj3xeTh2aPG0lOhW62nT0vjnPeb8VpyyHfNLTBNAolmwcKBlo2gM0cHFFyJ51
 salMoAGYWZjMsau9HfHg1tTRvjGpRnY1CcCIyP57u0ffocEzjsI0QzwrFYPeVqBBhvse5pZD232
 cGyRhqKHHebCSwtXKMP19hAafDzPBMQHJ4bWSRphTTqtAh1dBTHF/UaBZsr+3dGEnMzLUf9INTk
 k7jnt+ms4xGBIdsIU4QvP1on2JGxWpQSRYgXKNp1I6BVokmWoefyK8c4nH1tV0Xs8pJsPbR7DAT
 f45+qCMJlNhYT8JdDZRC9r8MD4U20jT4=
X-Received: by 2002:a17:907:180b:b0:c25:2ded:ad36 with SMTP id
 a640c23a62f3a-c49bda65ea2mr312040866b.0.1793197071561; 
 Wed, 28 Oct 2026 07:17:51 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd0f6f1asm618675366b.0.2026.10.28.07.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:17:51 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v10 29/30] usb: cdns3: fix up after the resync
Date: Wed, 28 Oct 2026 15:15:53 +0100
Message-ID: <20261028141554.3073545-30-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141554.3073545-1-anders.roxell@linaro.org>
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:47 +0000
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

Adapt the cdns3 gadget code to the new gadget API.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/cdns3/ep0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
index acff79ae1ca1..40282cbc3234 100644
--- a/drivers/usb/cdns3/ep0.c
+++ b/drivers/usb/cdns3/ep0.c
@@ -341,10 +341,10 @@ static int cdns3_ep0_feature_handle_device(struct cdns3_device *priv_dev,
 			return -EINVAL;
 
 		switch (tmode >> 8) {
-		case TEST_J:
-		case TEST_K:
-		case TEST_SE0_NAK:
-		case TEST_PACKET:
+		case USB_TEST_J:
+		case USB_TEST_K:
+		case USB_TEST_SE0_NAK:
+		case USB_TEST_PACKET:
 			cdns3_ep0_complete_setup(priv_dev, 0, 1);
 			/**
 			 *  Little delay to give the controller some time
-- 
2.53.0

