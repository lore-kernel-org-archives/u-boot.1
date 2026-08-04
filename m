Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0004FC55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 13:11:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C356607AE;
	Tue,  4 Aug 2026 13:11:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ehf5L4sOuGsk; Tue,  4 Aug 2026 13:11:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AEB2560794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785849075;
	bh=SyBe6HgHlxHIDY3j/Ra5/G5mohzkV8HiWbOI2367zS0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YDsbpaPvwSXHQ8uhQAQ47APUrMtg5Jh8UNVS/f+Aw5QiScuVPuwpx4lOad3qvzQOD
	 ZVtUfvCypX7KH8amhC25CJVDlLAJM804KXev6rwXAzLq8rCqMtyE5BnUoizqc8+9tt
	 AjgpdEKQhuui87w/7lCyRX9cpLAtUnwDqJKr/NHmgT5NZ/QrNJYVwt6p0o8ylYniZy
	 uBVjGM3AxkhijbOY467LRsMKWH6DmTb+/PjwwaXZkji3UiLcqgMcmHOwpkJ6UVHI1/
	 mMpCt81/SNq/hwPFZFgz5vvFqKT/UjC5LPeBeZIe4qBnKyNVan4GXw+1Hg4zMp+Uxi
	 vmQh56CLcIzig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEB2560794;
	Tue,  4 Aug 2026 13:11:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 189C626C
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:03:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F2A7D405C0
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:03:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ze2qaEpM9_Od for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 13:03:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 088EF40189
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 088EF40189
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 088EF40189
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:03:08 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6984169c126so7675707a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 06:03:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785848587; cv=none;
 d=google.com; s=arc-20260327;
 b=kQ5W35W90kDyB8zU2gLz3jOzX2RZWueN0XJABY002lX4OEwE+o07+dsBqI6Mo00kwH
 mYSkTHZHydAOP+SuGbtoV2jDI/fvXLEjaOOXcYZU5IDJqHEDHGOPmH070XN57fV+OX51
 2mHEVCaChTEsnArBbOJwDwhA+FpUN8qyauwi53pE6wVrExmRmwPnC/HtP6X8fUL3YkZh
 dbLxNB8HU1ZovAHGmL5BCeSZ3C76cc2CzmhQr+LpQEAJs/M1AvJBcXW7IL03vlGoecp/
 Tg0CLKXeX3U9PRvl9Lu8vY54KFh6WN0w/ULxj4ijNcnXiLUjgP0ahucm+DpQUXNTCUUq
 AdiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SyBe6HgHlxHIDY3j/Ra5/G5mohzkV8HiWbOI2367zS0=;
 fh=hsQzq9IYCmZwK0E7cVW3p7RZJMnlUShWANxf+Zzt34k=;
 b=SRGedTn+ObqPEOvsisyCCfUmo3Y3YUAj/L1PmoePH0k8NugZgGWoo4OpaTX8Wlh5EH
 EgGqXgkPwKtl5WD/HavsXDE5LYTjFuF7trZurhm3G5dIWtDYeLJOtL2sIrgUflbwjhfm
 dgWvMmBKdWRECwOjb1HjQ3p3krjcL3nGG0DzzofdqZzoss6R8MtW5iAAuZLAy/qK/z+Q
 PMIJ/wlJmgAB+OGBIJs1gfJeWBeyOBlbNKtI9TE30VA+6BE3yqshAo3SpnfysgUh/apU
 SsnhrIPHVOGsHE1Qyf/bNYWH8jhjR0VbxF1tBDfWWXRnhhw7eG8T0DOxeAwcJtlt7Amt
 YcJA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785848587; x=1786453387;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SyBe6HgHlxHIDY3j/Ra5/G5mohzkV8HiWbOI2367zS0=;
 b=Gmd88FQok2aCuBQvZxa40AGunmslRyogOYSVNHXN+clG6YesJwIjDs5Yx2n7fK3H65
 yngjmep9u3k6lajadA4Cvd/SRP2qKNw6JEUUP0BfDwfYINzIQ7bldIqME7RssZ1+3UKz
 ef2Y+WQhEEMjR1K6rADQZ65wHe0WQyNniDjwMFfaTMUbndrDyb7UFgQvdQWYh9ORl3u2
 FTRI1dC1SzKEke+eWjusrpF+4h4Iz1B5yJBuVNdYWc/o0OPgFsw+HzD/nivrYlskOeM7
 nnz/B2YoVm8vGWPchEdiEbjQuB1a6rOCCeozusvsQwOZbRVtLNh+OSA7Du4ZcB6MFhbU
 L3Sg==
X-Gm-Message-State: AOJu0YxCTkKpANicmE4wbX3PiP1BwTTbednMEF/X2nEZkl89/6cnzD9R
 Bm7AJ6oQmqHq8l4GhO/gCQRPZCKwSCiscVTmkN/5TgrCR2FhQz+Ia6mEo+t2lGiqE2kkWSM7Twd
 e9bGrLlheGQENDHtuxLdXgzrRVTLEbFfYNF4KZ+fd
X-Gm-Gg: AR+sD13hOpLtfOZ/kDRCAoHl91+5Y/nsSXxskdEV+t7P3TmzqrpNDGj35ccO0KdTH7c
 i04cwKv7El2i2caR9DOzHaZTfKesiQKniwSvIU/5WrQMewzQUXkyHG3HZBGPJ7YQ45mwVW4CpfT
 nQ8pavd4+FFI0V0cuGN2oX1HSiARx+ozj82FI+lpR0JJcOLNEmjNc5FQcHGxKK6sQPki5DJBPQa
 1mxwak7BxLD2vOKf81f1MiVB2bYnzNKoFcDehiWh23jCc4lt60Yo61aTvQ6E1e8kJecV2BtCixo
 De+HH/18e2GtnLaGd3ERRNebwY2aa/9UtzKkVr3TYls=
X-Received: by 2002:a05:6402:52d1:b0:69e:8ad:5162 with SMTP id
 4fb4d7f45d1cf-6a0a7c60ee0mr12060377a12.1.1785848586896; Tue, 04 Aug 2026
 06:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-5-acb97c172993@flipper.net>
In-Reply-To: <20260731-atf-falcon-v2-5-acb97c172993@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Aug 2026 07:02:52 -0600
X-Gm-Features: AUfX_mzA5grGTJ_hrKcu7kOV97ChJhd5sljkj90Mwx3FQc2zZ7b8_SXbnZx0iu8
Message-ID: <CAFLszTismHV2Dx-FKMDQ8416ZjWaXtXvKO6w5Wp88vcfp=z5Mw@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] binman: Add support for externally provided
 Linux initrd blob
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ronald Wahl <ronald.wahl@legrand.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 04 Aug 2026 13:11:06 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785848587; x=1786453387;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SyBe6HgHlxHIDY3j/Ra5/G5mohzkV8HiWbOI2367zS0=;
 b=guYlubt5YcmbfXBaAG5QD/xINx42ObQrDDwSgCucIOFD+vMlodTMhlzD5ssUtF+NBl
 5hUK1cF2ylMqHpCSbXp1RwE/6u/3I12t6uo78N0o1CBbBzdnH9SJNosykqmaOIsdy5aU
 DIGcN20bH8ZAo8N3SYaw8ueCFXI9w9N/5nZS8=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=guYlubt5
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-07-31T17:10:44, Alexey Charkov <alchark@flipper.net> wrote:
> binman: Add support for externally provided Linux initrd blob
>
> Add a simple named Linux ramdisk blob type to binman, activated by the
> "LINUX_INITRD" make variable. No processing is done on the blob.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> Makefile                           |  1 +
>  tools/binman/etype/linux_initrd.py | 23 +++++++++++++++++++++++
>  tools/binman/missing-blob-help     |  5 +++++
>  3 files changed, 29 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
