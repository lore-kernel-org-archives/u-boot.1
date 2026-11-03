Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356A7606A32D
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cmFOnBp9;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ShVWxkav
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12ADE60857;
	Tue,  3 Nov 2026 13:05:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2xf1RemBT6IA; Tue,  3 Nov 2026 13:05:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1032260849
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711111;
	b=cSXz1bwtzLlDFui+sHMPE4GcEVkN5Dg20KriWTtyFQnYz0I/WZ138JvF7I7MqaioskH0
	 n2rHH7cnAqE3Z6KpgOH4zjsKN4nHxMJrwUsj4LkSCeTKCB9CtqJovJXoV/1wZ6Jw4jfPI
	 Xsep22AixfJ6McpPmOpIrFJczG760MGM3xpsJTb/amq1BeHrwdpXbnjfKIQDJpwO3epVk
	 MY7+Wua+FRYwAw6qRKvpXux/Of+cAb2AqKjgE1oCE17i5QSKtW1fVr9SPetLGO0QNz/F7
	 uDBlr7SPZNvg4idYkmHHG0v3QNc+iT1RMagNRjo0orYvFdoTZgKVHMld/+aOiutg/jw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711111;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5sZGgll+vb5WjmHB1GRSpXrH7mseHk4yQG4xI7R7FXI=;
	b=ZSBQS5ENN9BMojZHieoI9bY9mn4mnlVuo8ZUoZbmTNf1ktGkd2OJlllk1JkCsOuE1vPF
	 xmk8Zq7ay1XiXvePqPQy6BN3LhoRcfbmSTI6Tb1EJdJctkkE5vCCKYDOFcyFY27ElKLmB
	 x7p0+WAyrY5o/KThJp06lJOXPxVtFDhD1a6OXG7q0ht2xZCjbIYOctljJq7CJuBeWAAHE
	 O3AzSs+ylkh3HBEqAA/ywjJEzMAi6tUbb6DbMjsebLj+YlajQQVi+uEqMXkTsiUUdwBK1
	 1J+TJxjolZe5kudvFoURMdSt7IjK6aKOI9s4oDymx9VHudFlcYIuWGjTCoznDX/8QZA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711111;
	bh=5sZGgll+vb5WjmHB1GRSpXrH7mseHk4yQG4xI7R7FXI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cmFOnBp9Wc2WlQR41NLW2RWIvnJLaY2jzkKzd8IkP++Vt2/LoYdwB4NztmVg9pvtR
	 7S41oUBNLTEAex4esdyE01jYJhBDKSxBR74lL+n/hQguNxx6a4YkF1vAnoczSbRbJa
	 te7NdXNsXtTYsBBeyzindHpy5tPJT58iV6GLIMwX0eurC3cuPEIDE6Oq+0vUUw9OTS
	 ZKNbxeFPsp20aOo6KHFHd3pQTpzCEG5VFKuEzwdibVx9820+i81yGTVDKrSxfGrrxq
	 OPQWuUpKMhv042I68JStnAoCRtBVTW1kGDghetGfZNJ/Til5HLT/VQJe1v/03HjG6r
	 xgD1+GuIaE8IA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1032260849;
	Tue,  3 Nov 2026 13:05:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2315BA15
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 14F3240080
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1qsgWAGB7FPw for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:58:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EC5D84005E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699919;
 b=bU+Hm9OIm2N6HBT++6quga78K+O4vFax09f+mw31ihfokTtvEPGDE9hcNhIl30ziK7DC
 LXKnELSsyCZ72UvDKhzBQVEx8KCeNTmxtg/YMf2slREvYw4OCIWU4Yeu7nl/WnXrkCPLk
 rcXzUOzozBmPhhl+ciCjkbcS9QgI+n93RscG3Zh0CGuT1wDDVfBpC+xE00OyZSvZp75Bx
 NAcmTnWSS1+0J0jlL1W2uSW29mNfqjcjCvczy1A8fTizF8s+LbkgTA1xKjOhHzAmKZCn/
 1UjFqi/KDMB6Y5qw+GZvOCjrbJQ5wNzEGqH/sVdb5kzShxFEDYRVxzyLmFWxbZCAugg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699919;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=5sZGgll+vb5WjmHB1GRSpXrH7mseHk4yQG4xI7R7FXI=;
 b=bwTWkzB7cXpt7p21rMkz/VQl+smkmgacJf/PVlO2xrp7SOkkIIQdVkLBOcOXUGR7a/uP
 pk4g7Dyl2nhyAiEBT5ak7RScFRBAh1qG20NDFJ0nvrvRfP0r0R7J+54VuTFtuRpsyJW9w
 XzUuTiOPMK1XBhSjFKWvuf2Di6wQEY+jj//Un24Yf6amqsy0NoOXzziwILILQmHC9rw9z
 WFnQ/okB699hln08GHA6zSKvrR1fUY5cTzNvnIG76283hpdDDkR0Kybe0V6ArXFZLjm0O
 D1PcQI/dJIgTcObo9XDCTcEXqTnBxqlQO+6yzoEy6ekqZH31tm6aqlLdXlQ+y/FqXgA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ShVWxkav; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ShVWxkav
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EC5D84005E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:38 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48e47347279so2459071f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793699916; x=1794304716;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5sZGgll+vb5WjmHB1GRSpXrH7mseHk4yQG4xI7R7FXI=;
 b=ShVWxkavZfehUJx1CKJzwbjkies/BZCeRSuwI+9zMh5b3X/Hsp5pjGEriNdbwwAuIW
 /1HCfX2K4PsqXSQqlN8nZ62oeZGPRFToGjXG8s7u4XhjFkTvpQUTBVZuBHS8s+WScwaT
 fGrwRV/dTHeQ8VfC+CnJ8ZLKiCNwf2sO6USF2ZyPJ3RQK6NYeBbaDgLketlcEmSjdRAT
 S4zq7MsMMx01thMxSNAS2vX758TMd0lWFGP3snccZ7yC18R9lhxZdlWSYqC9dgynJRru
 bDY6AyfbSHLy0bNomAT6XoVMq5qoGD49zyvYbwgmcM8Wqz2DHecVj4ooaKrFlUu+9v86
 y8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793699916; x=1794304716;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5sZGgll+vb5WjmHB1GRSpXrH7mseHk4yQG4xI7R7FXI=;
 b=A2EP+EBMTrVT21SSpH/WODZO89pIu3bwhvpGdznT+HmRWYIhR525kIJ5dmmHIUdmSu
 MZjENlBpK4qC+sl1+LXxohbsmdavV8ETuGNRI6COp4Q5mkGCFq0oFLMeK1AqHW3ElIFi
 NjyTcAG+XePb4Wx3dMg0APYvnJAh4+OpQvmdPf22nCsPqwJ942m6b10u1SE4fErXFxFy
 un13gxvvZ33YS9R8N2238XxBB0kP6mS//AFSlKbfgA0UcrHnfsqLiRDcBVP76IgPc05/
 AzQfvNgXrGP7tIzcdX0G3qjSpk96gJZz7qjdw167A5Vk/rYhP3YN7PAhANhnTFyOjT01
 MTcg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4LXRuyAfVm6Qji5dnVxFOFDmCj48f7TLpmVn+XRhwer30SrzsLQYQGF9CYUo+qmV4VUWTq/8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+YunRAzkLovO+AYRTU2yoZie/JkWbuEL+lh0Hwjwg93dHVY+BH
 PnqNNVPVP2/0y+xL60MgBT+GBcYK/jQttCx1YVhcLHMNOIcWdFbQRpMToRHtIc5uDnE=
X-Gm-Gg: AYBFou3uydINnEU64lfqBeV4F2gXUyrxn79Yb5OeH55+L9LmOGON2mDUCpGQplogoYA
 pnBDF1ObjQZtVkghRvSbsBPq8aYfQrTio51upRIwbem5FJ6/59gqOJZNM87Lmnn9cJpKtwAcidX
 DBjlCp7HNmz73Qb3WjRkgYLN6kwI2iZ7zR/3MtP4xDmjIagjpnJRRSDhH+zyMaX89+n74WLR/H/
 Ovov/30Pdu29KrFK5okEWbBUt3l+rJf3O3mIsurS5DawnXMs1ymDQgwzg7aDHSLv/4Wdsn4D8VW
 Po7wKnFfkPZd3w1T1IGGR630xYKCeVTeF6wjCvnwDJFj0S7Xy8/tucniy3oMrVV1wSVuOts7MDC
 0vf1pkBhDEiIkuMzAfTl0zA8zvNB/bkdNv3lOG9WP4dWI2iqhVXCprENcF/kGkc5R1dH6Xbi8BN
 Qr+wu4qi3uL4juxcxC+bT6CCk8qtZMFVZ2riObYnU4NTK/smp2h8huAXhxFtfSBD01y5T9vgH40
 TWk7UrWUokUJhpHFK1STjA2lp5OmIWSvgrj4f8FkSvdZ1Rf2h5sk+pmemmoyAiWXQG+ex/fwpP/
 FQocKe3mzyErtcwiOjoJUf1EwA==
X-Received: by 2002:a05:600c:4e43:b0:4ab:e27d:e241 with SMTP id
 5b1f17b1804b1-4ac180f28f7mr271788575e9.15.1793699916455; 
 Tue, 03 Nov 2026 01:58:36 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2ab3ea6a9sm69724885e9.15.2026.11.03.01.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:58:35 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 10:55:52 +0100
Subject: [PATCH v10 06/24] arm64: dts: ti: var-som-am62p: Fix wkup R5F
 memory region size
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-6-0b24ff0a4d6e@baylibre.com>
References: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
In-Reply-To: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, 
 u-boot@lists.u-boot-project.org
Cc: Kevin Hilman <khilman@baylibre.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Nathan Morrisson <nmorrisson@phytec.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Judith Mendez <jm@ti.com>, 
 Aparna Patra <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, 
 Devarsh Thakkar <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Stefano Radaelli <stefano.r@variscite.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Bin Liu <b-liu@ti.com>, u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1913; i=msp@baylibre.com;
 h=from:subject:message-id; bh=diUdMwvu24q77IOa7v5d/YmHcwyhpR2Ar3p3sy5NehM=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyX62+zTOK7euqX2pe9W8wqo/MtPh9mctA3mx/y//vjL
 KPrszSMOkpZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAi/y0Y/lmerzIVLTmYst9S
 NGfVnahNr6X7pn4qmfDO886zBR3Vy7QZfrPvmqN1/tiNrH/2Hj7sSzQvOL4xClywL35bhbH/iXx
 pC2YA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 03 Nov 2026 13:04:38 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The wkup_r5fss0_core0_memory_region was reserved with
0x01e00000 but the MCU SDK linker for the wkup R5F firmware on
AM62P defines the DM code/data DDR footprint differently:

    /* DDR for DM R5F code/data [ size 27 MiB + 396 KB ] */
    DDR                         : ORIGIN = 0x9CAA5000 LENGTH = 0x1B63000

which results in an end at 0x9e608000. For this memory region which
starts at 0x9c900000 this means a length of:

    0x9e608000 - 0x9c900000 = 0x1d08000

Link: https://github.com/TexasInstruments/mcupsdk-core-k3/blob/k3_main/examples/drivers/ipc/ipc_rpmsg_echo_linux/am62px-sk/wkup-r5fss0-0_freertos/ti-arm-clang/linker.cmd
Fixes: 571562e76458 ("arm64: dts: ti: Add support for Variscite VAR-SOM-AM62P")
Reviewed-by: Stefano Radaelli <stefano.r@variscite.com>
Reviewed-by: Bryan Brattlof <bb@ti.com>
Reviewed-by: Kendall Willis <k-willis@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
Link: https://patch.msgid.link/20260918-topic-am62a-ioddr-dt-v6-19-v9-6-40972ef1f663@baylibre.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: c9b15cd49b3fbd54f3382655b4e898921a7adb4e ]

(cherry picked from commit 8ea59b637d34c19559d5828d83e3df2c32257f12)
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 dts/upstream/src/arm64/ti/k3-am62p5-var-som.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/upstream/src/arm64/ti/k3-am62p5-var-som.dtsi b/dts/upstream/src/arm64/ti/k3-am62p5-var-som.dtsi
index 8a8dec80cb30..3d1a2c5bc464 100644
--- a/dts/upstream/src/arm64/ti/k3-am62p5-var-som.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62p5-var-som.dtsi
@@ -71,7 +71,7 @@
 
 		wkup_r5fss0_core0_memory_region: r5f-memory@9c900000 {
 			compatible = "shared-dma-pool";
-			reg = <0x00 0x9c900000 0x00 0x01e00000>;
+			reg = <0x00 0x9c900000 0x00 0x01d08000>;
 			no-map;
 		};
 

-- 
2.55.0

