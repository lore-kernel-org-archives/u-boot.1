Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25443CA601D
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 14:59:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25A8F40932;
	Fri,  9 Oct 2026 14:59:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NQJ4-vjyj6kf; Fri,  9 Oct 2026 14:59:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 74F9240956
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791557940;
	b=sNWrqK6z01EIu+AU6q6uvI2UBDkk7Sw8ku8R13c3RPFfOjDXo3yLAD6UKPWWzFgJL3as
	 I54z1oVvEc1wlFJGOiuG4cQBT32D3SGt3zATB6f/6UH311oVbjWs9NkgujVtpErD7Oak4
	 +PjpyUiYssgcFhHLmN6l3Re6NbcEUeBshiEV7kV4xOswvnymAEJpu8F/Im4M13SVLOGBF
	 b8EzueYL7+YLXGfe+YyiN2q/MWpMDJOE9vc013CcQ+IIL8po0A7QBSVH2C6MksjM+1UFw
	 V6Ts9IHMJSnlX+ZIvQkmNtYKpvny13ebJZXCr0K7NgB5/pwTfdjkIgBYMH3Qg0aWRdA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791557940;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=VQXHWTQnwEaOd3WCdtxhSpraWg6yzJ1WDpZVT5kPHKY=;
	b=RbCzi8IVQGw1KgHzp1trOfMhy/+sJ0ThwAcLf6XNmlz+NCF++9WUwSokmwXAWC980XDi
	 d8nbXRQPoz1M6g9gq5f9L/FhMfJ+SKk3jrtYHyWMd/ERsOyfjsHP7+JU31B/rwhmiGL0d
	 fCZgN5CZPXn7fYJ6kLKI6Bfyec2oCgWpj4KdaV0PNTqznGTGYAK6myK+1+24QkuQ3bf6g
	 I1ZsOsgx8PgZvccSYpb7LMXnNdYIYBSHkhZQJobV94cOFY3W5UPV7V9lohAhZ2sYlgw9M
	 et/5yte5/WCxeB4jC6ZZuGnD+rmEMVpxUQ8U92SL/vKsALpfwHwKnHS8EXJ2wxnCfwQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791557940;
	bh=VQXHWTQnwEaOd3WCdtxhSpraWg6yzJ1WDpZVT5kPHKY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=opfPUpfK7nLdo2EcO4KqiWarwSun5KHre399seyyN1l7zThpaOpbPRapij8UbtTK5
	 OQH113RxkZKGUCzEg8sT4UZb801AE8jRQ97j9c0hikvUxxvkNT2nK7k/JQKRgBEQe/
	 t+lypm+GY7Py0iLJlPFGqBfWkm5Jefj9IeKslEw77MadO2RG4AeP/StxPTrd6hgSgF
	 UJ7QXXnjkSzrjHPNNUTwhFlrtWcqugpbFl1xopzBdOcfWxvzQ69YE0O8EHGZK9ESnC
	 Po8kz/jjOy8f8GhoWkCMFNZ6jAjUJ0frW7VQt5Y845VB8Ng2AOMLTYhYOk0a/WW4+7
	 om7th2LSWMMjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74F9240956;
	Fri,  9 Oct 2026 14:59:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4360E1D2
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 14:58:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 350F981412
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 14:58:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pAj4I8Cfzez0 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 14:58:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 93E1C8138C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791557936;
 b=WzzpvC3jQ2s5Tdhtm3IlBItIvoPpq9OypZpHdH40dBBEmc1MxWHqSq8+WVYSVSKWbLVw
 il9YSMlqWhMhhiF57vO8vLo8ku4uNHg7c0GnlaLvbhujkPyU105o6vLy0SFonn4m0hYtp
 5Zxm5v9rHEVMeTbY9BQnHOqO8fjt0QU33RGy61uBSJOFrmNUW+0Jhs/oU6k5F++7DT06n
 PuWQCB6aCuUxD9IGvqkXxMLhXiO9eBHHF2pWAAOgoX7SD0wUlD5N0PnrQGKwjo7H40V9/
 UNq4Vp+3hQ/HaS3iQ0AtVlLh0hUvFVNHgjf8Kl9rWBsbYaBwkM3tR1Vpbdzf0b9Jt1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791557936;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=VQXHWTQnwEaOd3WCdtxhSpraWg6yzJ1WDpZVT5kPHKY=;
 b=ssEPwzAQt1vFlQu08whPDdPFXOxj5R3HIZbsZLa1fYw4TJAI0nLvOKTIdDlyyuOA28iX
 elgfIxnwQudivlMBg1nVUEtqL/1n8oA5nlNowXKN5EeETTWT7+WvAmuqcuNm/LUo/+xqV
 TBO3yoltQuBRGvP2QGHuRqEwEyr2UGzBjDvYeAtjotAtaOfJMqAegNfalI24db2LRd3OV
 KffhIof8I1vQ/XBEQzUB1PYaLZCnNWNpJJ3pv/Jl2cMF3BRm50gCOennjcwh/SQzPiCBk
 1Y75tSKCzQMn1tBN9youYQxWIZ5EttSj1X9vJEBB3jGaXOnwmpl+TPtYzdxmksYhhrQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=n0t+Lx+L; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=n0t+Lx+L
Received: from mail-dy1-x132c.google.com (mail-dy1-x132c.google.com
 [IPv6:2607:f8b0:4864:20::132c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 93E1C8138C
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 14:58:56 +0000 (UTC)
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-3514e7cbbbaso8754320eec.1
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 07:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791557935; x=1792162735;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VQXHWTQnwEaOd3WCdtxhSpraWg6yzJ1WDpZVT5kPHKY=;
 b=n0t+Lx+L716kyqOOhTbpQd2qI5R38AnBSmPP4JCLVa52s/6M4wZmw6a9lrAdPUnj3q
 CkDpSPsHcoaDT917ojmmG+yRYpdEoLPkOJeZ2oBr3r6cftfGgRghchAYYul0Xjn4O8Fl
 3wrhp8B6uMboe3VdlurwiQYwbEh+Uh1tuH3dQeagwRRpkMpfzD+O2T7ZeAR5sUNUh5xy
 9j/4/oyKT08TEF2T8yKTHg2lWd15hya83iiGHTTU+zP9Y2c66Szdx0zlXHLsxZ7XMSWp
 zDpMT3SvGwFvaZ+UWirCqJK8EBbKc6PPN7VpXiio0u9bTyC23DVy5ggUvITTkIym0YnV
 JsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791557935; x=1792162735;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VQXHWTQnwEaOd3WCdtxhSpraWg6yzJ1WDpZVT5kPHKY=;
 b=LuDQDRsABAJbR7En1E3u6dR9bVTAWNz6JprtaByMPNCd6d+eUVv6aXqudFLVreWJYd
 zYXYBdHQkiEnorhstVOD08Jux/yg+TMGyloSoD1ijuNoxmGFkMD/36qa4dSzxLoxyQY/
 YlhkkVe2sBun+wCuws4SuHF5H0aB3IwYI4KSeiSG0TKhHHzeTx9ugDTUdWqucdC/uUEE
 b7BkaljVmK6PIsJEbkwbsWvpC+gn4+4N26aUmKTA8DmLT6K1t6GD14dngrRZqIiwC/bB
 6JaV6dEip6OKtaRLa+BqAks1Px0LvVaJq8qAmQJKTLdPJqh3gmmiDUe15JAin6V3DYEn
 3iHw==
X-Gm-Message-State: AFq9FYJZ1/5iVmneh1zIrO18jvse46V4K9AQM9cmT8pFWLw9egMAZMxp
 Q4ISNkEGv9PeVOSfwY6HtjztZQVCPO0GHrHrC7hxTWpd33cyRSR7l/qwO3UwtF/D61c=
X-Gm-Gg: AYBFou2vis5Xw+kRbFBI5nFipClpOoFl+OEUjyPX8uczFsEqpbjYE+mOKdQuPqZS5Af
 sjk8gHJfDJzUx0mzSwu8C+4YeUE9IV8Av9piaebtaUuO0A02zJZFelh4LeVxbz6Zy5ZvfYH5VMT
 LokZT4IR5Ea0qO92EbNAr1QsCCWYbli4SboTjqsigGOKehUOdjn38sMAzHM9MyNAu78n3Dyw49X
 8gBuwnplCrIGF520kwFh45/yus1i+viTZ8BzQjoehAF0riDntcvPGA+fFwcQBPDemV0AS31cJ/w
 qysT3w/YkA9+rMKiKYOMCt861Uqft58mO4oyznKatsX5GBqA41W22n9rZV5qp3JhO1B/FK6BTuT
 zznXm+LfLGrrV6JMUksplvQ2cpv9ekztFZR/dFx95NnMuxV9tQAkIMVxiEe8GFP+WSDZeOx8r/Z
 CoX6tlSTHhhy0Om2uSThDhSTSLHLui8cwY9u/3hdw/nYMLjIu3qm5Rn9s8j3yplsZHPjZgABUTX
 XlG0hI5fG9flDNmu9eUn3C3Jil+ANFFI0Zyng==
X-Received: by 2002:a05:7300:f58b:b0:351:2a16:84b6 with SMTP id
 5a478bee46e88-3537dfff2fbmr2617313eec.30.1791557934053; 
 Fri, 09 Oct 2026 07:58:54 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:4c5:8bf0::ffae])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca6d202sm7126892eec.13.2026.10.09.07.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 07:58:53 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
Date: Fri, 09 Oct 2026 11:58:24 -0300
Subject: [PATCH v2 3/3] configs: milkv_duo: reduce CONFIG_STACK_SIZE to 1MB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-milkv-duo-bootstd-v2-3-c4679e726d10@baylibre.com>
References: <20261009-milkv-duo-bootstd-v2-0-c4679e726d10@baylibre.com>
In-Reply-To: <20261009-milkv-duo-bootstd-v2-0-c4679e726d10@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Kongyang Liu <seashell11234455@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

LMB reserves CONFIG_STACK_SIZE below the relocated stack pointer. The
default 16MB is a quarter of the 64MB of DRAM on this board and leaves
only about 1.4MB free above ramdisk_addr_r.

Use 1MB, as the other small memory RISC-V boards do (sipeed_maix_bitm,
sipeed_maix_smode). This is well above the 128KiB required by the UEFI
specification, and leaves about 16MB for an initrd.

Reviewed-by: Yao Zi <me@ziyao.cc>
Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
 configs/milkv_duo_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/milkv_duo_defconfig b/configs/milkv_duo_defconfig
index 8c6778442e6..c6c0dbb4be6 100644
--- a/configs/milkv_duo_defconfig
+++ b/configs/milkv_duo_defconfig
@@ -10,6 +10,7 @@ CONFIG_IDENT_STRING="milkv_duo"
 CONFIG_TARGET_MILKV_DUO=y
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
+CONFIG_STACK_SIZE=0x100000
 CONFIG_FIT=y
 CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_SYS_CBSIZE=512

-- 
2.53.0

