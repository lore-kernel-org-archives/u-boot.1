Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAF8606A320
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=trVjBaQy;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pRkYIyj0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9FC1381771;
	Wed, 28 Oct 2026 14:50:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9VPg25oIYASk; Wed, 28 Oct 2026 14:50:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8E8E98125D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198916;
	b=RD3XHLOHCQ4L8PgZNeNdYTVpsrwBvPUadhLEhZtgNMLhs2HgRvaur+gkA372LVTy1KqA
	 SjfmXyxCF3iC5e5OeG0euvJmjYONm3kiMtniOaUz1ghwE0YiXsejEH7xCVkQqThS1nXks
	 6JMCQ9rxVkcJuPkF0Ut0Wyl2y4rpNlCSMrlvZ0JtgMwml1SU53vkWvBcuk7vFN+7AVamF
	 QPT90aqHhTx8IcnAqZgAdYCthYe5jKS/Ly7EbMVX84KycP3APntxFYYgbvAxfO1u+Wr2B
	 KXbaobKtD7VNW8V43HbwWKEgtW+FZUVsn6T7Ac0xKyrKH8EViZTnD+rvQnAz8n2O3vQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198916;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Uuxr0c86ovzf/ZM+5leNXnR6OcA4HwH1GNRMh//aGp4=;
	b=FTUPIGuICjGslKnTPUpLjioTQhCLD42K+nwB77J9RNCbUEwgDehbZMm9/IAmA/UL6coi
	 NeHrT6pJCn00zpA8gBSFR9mlhIwoZwg6i33AbgU+3ztaWm9H4cBwXeihe50J/MuuYhFCu
	 rQBq1D1zfcF/sWKw/xV0vm6pIbFBjJD46oUcfrceQHXRiT9KcsWUhtrnKIbONqh/PdyDy
	 TmfrdJPmhLIBZSMt0MZcuX3nWHj6q83kZzz+0RWDpzpWK6CwEtaTzutolIO4ZtbSGuykf
	 71XkbbWh+COu/WjeyKcSeg0HhNIKVMW9o0eaBVATtc48qpoWxxi5jLNwaoLDtVkO3EA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198916;
	bh=Uuxr0c86ovzf/ZM+5leNXnR6OcA4HwH1GNRMh//aGp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=trVjBaQy62lvX+AqtI7xt/9pnjB6tGIYQtiNSY9qGggg6kJxuHrWrvUjM3zlmOAtI
	 XcsmLsP4c5GWLvg61aUr2WYIqhuzxwK97ZNucSTmsvAXVH9Ue06ztudRNS7LGEOGv1
	 SPawjd0J1X8/+/6qHcvCJA9M1phEsmx+vEyZoyYHU7eRMguXNx5HiQVUtpgkNB+NUB
	 VmQvx2HuawXSrDAZhBnQYy3YR4MPQdXPv6Sv8I0eW++saD8JHO78qeocLQG6UInePa
	 F0WnpxlJfqkVdd+pCiyEVCfJT90DmhovumujnX86vw1g+HP/VfEch6BCbIp+3pERN5
	 m5hTe3NRokE3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E8E98125D;
	Wed, 28 Oct 2026 14:48:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5FED1356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 51B544009E
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dlAUpuqvD-Q0 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:17:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7C9654008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::632"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793197063;
 b=RSfsMsvNjpZ4cE+jy8dEylPybVt+1oyeO9AIqPMP8SaRE9voSl4oOLYGR58sGnLlUXix
 o9PFJN52lXM4LAQSX4XodaD+HUIj+LverQ5k/xi7Z/0KsXjwL7BIW2uPA59r3qB+XnPRO
 wZ+RU7SJyimnBh9j2Atxouy5bXH8BFmLzuNygbL6wY2bLSrWli4RG4+97dE5oujutAqFi
 GCDK3+CheHpsxweRFE2lJgSWJWFd13okWxz5MSu3iuLoCGsMiMBXnO6TdYJnMAv4yh7C3
 RDlAvWjcvYNb9zzqTS+9QkF14Fq2ZBn+zV7i+D5Rfu59d4DXyuyhpTsP5fYz/C5IrpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793197063;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Uuxr0c86ovzf/ZM+5leNXnR6OcA4HwH1GNRMh//aGp4=;
 b=a8xsNsSI+TLCalQt3LgFmpX1VLpnVmDcqhVWebpk5oyEaF1dSYLYz3lKkJhTSVeox6WZ
 8PYEyswEEjammFbvl66ZeT7wz1IAmLHVncnfJsI5esEpobo+M5aA6vdR9uYxEeKekRBVg
 5MSu16MRr2JA3DfkrshPQhUeHh/wz/5SVHs6gPWJC1E5xlZ/kDcZQdjh7LCrT74Fah4wb
 1gvWrtERAt72YL64omvCPlot/TPehTn1WiVD5S2iqoL3klsSYbDyr61KCIlyAXFJcXj4g
 2kWHQHL0BG47PwkCGrCZXePhcsj6n8z6EYDqx3R0nP1HdWcOsyxNo4Ii0oP9ERyfJ8A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=pRkYIyj0; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::632"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=pRkYIyj0
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7C9654008A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:43 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c347be93d54so11444966b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793197061; x=1793801861;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uuxr0c86ovzf/ZM+5leNXnR6OcA4HwH1GNRMh//aGp4=;
 b=pRkYIyj0vkf1gKm3tKm4e1oSaf/SIwXJ3bGrzECf7qEEBFbZH+QJ1r9UVWg3OZuAJ1
 odq+IzF0AkcYPHadpQuLsdf/rM2iowuFfYPA1xZV285ixrMPeVpRASm8KCSNQqWKfFy0
 HwErIuX5eU8uJqZUc+VxMwqwZjcl8MN73acZD0PnK/FjYsXokoH+LyU+/S7ppUhDG8EV
 sXGe4BW/tJLL8UmwijOPL2yJCQavnIs7iokPe00jFGfQZCGBqcNJkw2a4NtMwKGU5stv
 a7k4RSfWar3PE/ktT9pNszMc24yjOptnIN/BgrwCEVf07Vpp00cFks5sEFF2ydO1AIlR
 +Oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197061; x=1793801861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Uuxr0c86ovzf/ZM+5leNXnR6OcA4HwH1GNRMh//aGp4=;
 b=wgNHhIO5J98TSrymzFLrStSBhGdSUNOahlo90SflBelfRaeYhp4zS94JSA8XrpYgWd
 +CdxUKsTWQDNxA2lcO/dqq9BUPuHQSFwTOeT1DP4i8t46Rbdwykk/X4AWXqqd3P5h5ef
 B2SdFm3IIX0umNfJdSgwzhKskYswBxOgakERR0SpX0Y7qGdQUKQNXp28B3L9VOcWmnsI
 p5A+foI/xw6bXeezLu7JZgNx+U2G6breXoBXIe+L+ybGfTQ4NdEfmiYlyl0cNvSEgd3Y
 ER1wyfP9K9xUpG1S8gfKxf8VJyEpHMh5OvQJq4rb9bIZ0j/Wv5S2Ex8GjOJC3Qms7/fR
 HMCg==
X-Gm-Message-State: AFq9FYJ3GwZgjUoBgOKZzrtXZUaRdJtUycUrejOQ7Y82+ZGkWm02XIhQ
 0WcoAfudVW9W8+39pcoo+3n8mNw8Wa7G2HAORFTxQAXL46TPzgxgCCgm8/v8lhjOBpcOB/ZuKoa
 mytcL
X-Gm-Gg: AYBFou3Vpnri3gA6AvLEBWZr+f8bNatasrWx1pzXvQu4q+iRJ+viEfHasY5pJesZoZZ
 QEz87aTT4wWlyR6m9VnmBeX/BLDAa7Ajdsmcf3S2HozHB6H6kWFhJrnS44z3LROumkaVeHDRftv
 rQmtoZhpEAw2ZDQQUMHvxjRyLqRrV+vnQuGoVF6fAf3ds43N3lAl/1JVDPA/NA9k3tQCvwSZaFn
 8S1Sxb/Aa9ZWkrpF+CJws3ERm017TbWMFZBRvPIZdDWdY5xQileHjD+C3pstXltl+SMwHg76lOH
 rH/oRAsqrX41sUYWEium8ISD1ReqXft+hvt/ayN3lCX7p3+b0jQ2kNm9VA8V4vIf3SwdaLxcQzy
 BsT+ST2fs3vTyy54BfdTYwTXHwf6b6UGqiJI5zrdMqrxbvVTBKH+pUe7neUk43ng6fMfAuSFVlN
 qsi5KCne846zuaQGQ0xQ9uTxyA/889t40WXf0LuRT3kGew2udwmrKhwu44HeaxshmvTAWPJL3Z2
 nlJhZrfYGEU2zSjVIDnhqrSJ61m69r149uJqv31mpQz56bzu7ot1jOTgvr+PptX/Z5RADfbrbl1
 lkjs4XxsaPsr3OXlfz3x7GIDEVeO6aQ9f+M9LUmD8PuIkf3caBajJrccyLkhoHA5fNMXXzAa+fd
 nQrwAYXgZsA==
X-Received: by 2002:a17:907:da10:b0:c25:3ec4:9e43 with SMTP id
 a640c23a62f3a-c49bda96afamr290744166b.0.1793197061190; 
 Wed, 28 Oct 2026 07:17:41 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd0f6f1asm618675366b.0.2026.10.28.07.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:17:40 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 22/30] usb: gadget: at91_udc: register with udc-core
Date: Wed, 28 Oct 2026 15:15:46 +0100
Message-ID: <20261028141554.3073545-23-anders.roxell@linaro.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

udc-core provides usb_gadget_register_driver() now, and it only knows
controllers that called usb_add_gadget_udc(). at91_udc never does, so no
gadget works there.

at91_udc_ops already has udc_start and udc_stop, so only the registration
is missing.

taurus and smartweb call at91_udc_probe() from board code and there is no
udevice to use as the parent, so pass NULL. udc-core only stores the
pointer.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/at91_udc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index 5b0c55d59c8d..ee2af2d699ff 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -1494,6 +1494,16 @@ int at91_udc_probe(struct at91_udc_data *pdata)
 	/* Clear all pending interrupts - UDP may be used by bootloader. */
 	at91_udp_write(udc, AT91_UDP_ICR, 0xffffffff);
 
+	/*
+	 * The boards call this from board code, there is no udevice to hang
+	 * the gadget on, so pass NULL as the parent.
+	 */
+	retval = usb_add_gadget_udc(NULL, &udc->gadget);
+	if (retval) {
+		pr_err("failed to register udc: %d\n", retval);
+		return retval;
+	}
+
 	INFO("%s version %s\n", driver_name, DRIVER_VERSION);
 	return 0;
 }
-- 
2.53.0

