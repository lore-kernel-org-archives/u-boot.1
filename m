Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E32CC6B12
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 19:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DC1560806;
	Tue, 13 Oct 2026 19:33:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oJUw8eSDgIYW; Tue, 13 Oct 2026 19:33:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A06BB607EF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791920035;
	b=BVuHfmc3UJdgX25bdGY4rzrDpRzMkC765JPNdsVKnfjiiOzLcxYuqUKNuBfXQSLQ9kPy
	 8TCa/hufGagWuiP/KVJtnUUuLrvv8fQARMdG4RVY6njccYN1dJ9bC7QlgCvbCQjvhLVCn
	 VAGu2PTcggB6Tmd0KHEFfzWZRSzSHT5gsHP/7t5kZ7yepL2DZ5429Ntk6gfuknKjSsVxm
	 BpoDOLpzCnav7vNz1YLG/vi7KArup1SyNxvZ9apHDUwhmVZuLPTVbtJFASX57gI0QJKxM
	 bo13Z8gHs63+0cCHtoFcpagUAizyPuMotB2xjACdXXaMWSugDbQSDZ1Nd6CLZnrvfig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791920035;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=dNGNf/MRzGcUq6xc/Dpm6UQJg3KzD+qvPEusM3Nl1h8=;
	b=szpY31ZvqXGCePWtyZDPwPhtfc4MqmUFxQgW77dFihYJVetc5V63MmTzhzCGWqNNNrs6
	 B20aZ9h5U8U0hRtsigkepWQdslnOZAYkvB6GlI5dfjwi9hEzEcL/8L/pYY0TZ+DOKnCvs
	 ctJ6bcZFlARHERTEyB3i9oPS8JeLV8idQSNnqIyp3pHGC5HoZAWIl6iknSsLT61MQdqRq
	 5ib2O+BcBy5cJtjzkUM1W2iaNoUadrFCsL+tGvWy5orkHNR3RfHRZhZSRysRzthrupFgL
	 d7rF7FX77jhKQNiFjsPy5ELLPsObDI7rKKy761oupG6+TRrBQeKjPpZyLQ6vZXOVgAA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791920035;
	bh=dNGNf/MRzGcUq6xc/Dpm6UQJg3KzD+qvPEusM3Nl1h8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FAjT8cjKyIJMYSNHdmyAH9mlgi/xKhSr9KPO5H3EoHKuP7Mm4/0mV9/h76WDr1AxM
	 WcWvfVomPWsve1AM7iIymtAeNNyD2tdqcUkYGaFg9z6Y26nHq18IFPKfwToJuA1Won
	 9wYCXe9cGDT2GtUt9qEVlslyty4gJSSNaPMrScXKRB39J2R9IzMdfBRPx9gsQ+12Po
	 hncAZl/nuFPuujDFYRoYiLSMMSF1BjFgagpig3MCGrQZEPrBG494KxeG/31lUep+TB
	 UKWKiyITmTzwh7wLFjQvoDsR9FhaJsUP64NEh6cnciko9jSemCMRsMAMHjINk0dbrq
	 9EWjmEMJKV1IA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A06BB607EF;
	Tue, 13 Oct 2026 19:33:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2890E2AE
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 19:33:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1A5B6402DA
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 19:33:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g-HSlDAP9EeD for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 19:33:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DA46F4008F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::3"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791920033;
 b=NItHiBczdIWfNXki0xm/FYjvxzOyEFvEIdiHEgdDR/wytg03kuXUXmJM1InfZtyIHP8S
 et3Tb4PvfvcKSsZOw++H/lwJvPTxZAVpCdM0SBLxrS+kyEP9omKDuWmH3pQ9cuHqeApwR
 LSdudesirv5ddGhrxQPBvlmrzGNy7heELNfY+3yzTHZpl3YAFKl8Nztt2sUz5P/rqD1vR
 IEQVoGlBRTFCm77JyFf2kiEUTOBLm6nonVmdZIzt3k/ln3tVr/dZTdb3s3HS6MuW0qQ8D
 /OhujtziieVFeGoXTVkGPmBusCbYmQ93ttKcK1/h6cVi0FCmAFO0SB2Y/GkBa616KOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791920033;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=dNGNf/MRzGcUq6xc/Dpm6UQJg3KzD+qvPEusM3Nl1h8=;
 b=cYFOxsqGfOse5uIRjDhuA5Z58y6bYmSDpzQfVXQeIYagjGj+Na7X2T7iDncChVyfK1Sf
 zNAXE6VSEkpml5/ClFpdcX0B3wlh2nWsKXxWajGbF3Egyl/e+VDlnazfU8uWRAKHkDU7x
 wE9eufenriUAGh0nAYDsIhIAOoGAnHUJ5ze0cUpiSv5UCrKb1VU4SsuMQZp5ave/BSCWv
 QP/hmLbuJWdxOv56M5vWOtrWm8owte7eh3cjKiCslN9dZyb+OEzsQksFk7z4JwlB5bx4p
 N0E4Y3rL6uGmdL7V48q4QaoDhataiclYVm5wFR+JTcORYAVfyNp1kEkrfMG17Pk+U4A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FsM7sSCN; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::3"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::3;
 helo=mail-oo2-x03.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FsM7sSCN
Received: from mail-oo2-x03.google.com (mail-oo2-x03.google.com
 [IPv6:2607:f8b0:4864:31::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA46F4008F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 19:33:52 +0000 (UTC)
Received: by mail-oo2-x03.google.com with SMTP id
 006d021491bc7-6f4cc0bd537so259184eaf.1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 12:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791920031; x=1792524831;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dNGNf/MRzGcUq6xc/Dpm6UQJg3KzD+qvPEusM3Nl1h8=;
 b=FsM7sSCN3RMsY+BT04GHAUtqTR85V1ye7hLGpy0B6oDl+a+g2Tia5N9EAi/d7KtU6c
 cWCglkNKie6ZydSOi36mNEfniOy0nHPZTyugMbr6MQt9sPVAJOMivO6bTLrH39c05zJo
 emF3xOv2NVtQKvtBGm8AolHkc3CcCG2v1IlK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791920031; x=1792524831;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dNGNf/MRzGcUq6xc/Dpm6UQJg3KzD+qvPEusM3Nl1h8=;
 b=VFEQcssfMf4JRSaWYsI3l52LEtR8uX13BbENGrACqZGJIKvdXtkeOyJ2R6BErC/ok5
 qvzsVhSN8fJegtT7ezVBeJrF+B/W3jMleWihx/ucl/+fd+/+p4fca/J728cNu/jfZU3R
 9Sj0LRHR80tQAuaeEORMkbl0LxKTJh9HDPfE3hXJS048QZgHwixRlvzY1o9oebUD+BCR
 Ikdk3OftztDfDYPf91zmzWYMI06bHnFrvaFQfPcX6j0glN/cy54wEA4FYdPJ8HDKcGbv
 3F7Ycg85rbkkyWhWw6a0Qj2tVAotLAKgRyuNJnu/6FJ0jSfHtHGasWFkkOA9oNgCuQvm
 0Ujg==
X-Gm-Message-State: AFq9FYL8T9Ir5695dRP+A29+F3Z9RPY4xcjC4ItVFBerst7zQB5NeAqr
 us7uvsP+uC4EXXFMUuBvkhixUNIUsbMLGbv7s1+j5B2HLuMC5zZYdOGwuxwOuzos9mQ=
X-Gm-Gg: AYBFou0rWDedXM2SwSQ6NE2GgWPaC8Wp9wdKQlOq6PnaNg0R2JiYFH9iAJh9QyZOxcs
 pGuiNK2VybEYQ8cVZraJ8MVZ4ZrtF0OhhYdPwlijLBc2D/iaygKQyqAIc9dwsU1ziN1+N6MEpOm
 l1EBUGD9IzKfHe1R3WfpgIaomWsJ6TGGcbwM5f/Yq4Sk017KG9Kedoqt0DUHgVCEqsqARfu8D9J
 aRHYJDLcElPVWADKRNsbqF25JTDrNmT2635tnr7SOQv2Oo8+TnPnyY2DTZ+SjmckV1+xO7GOOJ2
 b4NQZ6pGhsxL1hfpBs9vjJv0sFMjClY8CE1+2sRQcnPClMGb5F2dZtLjzjtSoiQdFuwsuw+TEvU
 cmmLpRMFD0+YIWrGEAD920KgIzbOuhHfIMZ60GYO6/TDLJsrpFP7pRVjRyh0mNZavSoOrR9maia
 eoId7+trg/HGsS2u1CB5rrG40XdftAhMp1ZSV2y435kp4OG+QBxtGCGYGm4tMKCJIPK9otOAe19
 JJLR5jo7jROMC3AMCJCNQImuamEiGmAvBL7WOzewASNGq0hRW3QUf7WcPUJDBXNA/zizpUKUvSi
 5kqw5nVP32wGEKuOPQo=
X-Received: by 2002:a05:6820:1693:b0:6f8:2346:cd97 with SMTP id
 006d021491bc7-6f82346d9bcmr4089206eaf.6.1791920031417; 
 Tue, 13 Oct 2026 12:33:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-830385b9cb0sm13496645a34.4.2026.10.13.12.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 12:33:50 -0700 (PDT)
Date: Tue, 13 Oct 2026 13:33:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Vencislav Atanasov <user890104@freemyipod.org>
Cc: u-boot@lists.u-boot-project.org, Janne Grunau <j@jannau.net>,
 Mark Kettenis <kettenis@openbsd.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Subject: Re: [PATCH] New platform: Samsung S5L87xx
Message-ID: <20261013193348.GF4042005@bill-the-cat>
References: <010701a10b3e4582-979b6c8d-12c9-4819-ad7f-7ce925de5824-000000@eu-central-1.amazonses.com>
 <20261007191312.GD3079290@bill-the-cat>
 <010701a125702538-042eab3f-9dd5-4f9a-b8cd-8d60474a8910-000000@eu-central-1.amazonses.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fn+S73J9R2iSg8y5"
Content-Disposition: inline
In-Reply-To: <010701a125702538-042eab3f-9dd5-4f9a-b8cd-8d60474a8910-000000@eu-central-1.amazonses.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--fn+S73J9R2iSg8y5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 10:51:08AM +0000, Vencislav Atanasov wrote:
> Hi Tom!
>=20
> Thanks for the review! Please find my answers below.
>=20
> > On 7 Oct 2026, at 22:13, Tom Rini <trini@konsulko.com> wrote:
> >=20
> > On Mon, Oct 05, 2026 at 08:46:32AM +0000, Vencislav Atanasov wrote:
> >=20
> >> Port U-Boot to the Samsung S5L87xx SoC family, which is used by the
> >> Apple iPod nano (2nd to 7th generation), iPod classic (6th generation)
> >> and iPod touch (2nd generation) digital audio players.
> >=20
> > It's very nice to see this. For the next iteration, please reword this
> > so there's more information, and also the attributions, above the first
> > "---" so git doesn't omit it.
> Sorry, this is my first patch using the kernel/u-boot workflow, I was not
> really sure which part to include in the commit and which part in the
> description text.

No worries.

> > [snip]
> >=20
> > Globally, there are spacing issues where the changes don't match the
> > rest of the file, please fix those. Similarly, please run checkpatch.pl
> > and make sure there's not other fixes like that to do as well.
> I've ran checkpatch.pl (using b4 prep --check) before submitting and the
> output is:
>=20
> $ b4 prep --check
> Checking patches using:
>   /Users/venci/Git/u-boot/scripts/checkpatch.pl -q --terse --no-summary
> --mailback --showfile
> ---
> =E2=97=8F 93571ce45b81: New platform: Samsung S5L87xx
>   =E2=97=8F checkpatch.pl: arch/arm/include/asm/arch-s5l87xx/s5l87xx.h:47=
: CHECK: Macro
>  argument reuse 'i' - possible side-effects?
>   =E2=97=8F checkpatch.pl: arch/arm/include/asm/arch-s5l87xx/s5l87xx.h:67=
: CHECK: Macro
>  argument reuse 'rx_pin' - possible side-effects?
>   =E2=97=8F checkpatch.pl: arch/arm/include/asm/arch-s5l87xx/s5l87xx.h:67=
: CHECK: Macro
>  argument reuse 'tx_pin' - possible side-effects?
>   =E2=97=8F checkpatch.pl: arch/arm/include/asm/arch-s5l87xx/s5l87xx.h:69=
: CHECK: Macro
>  argument reuse 'fn' - possible side-effects?
>   =E2=97=8F checkpatch.pl: board/apple/nxx-common/nxx.c:15: WARNING: Use =
the livetree
>  API (dev_read_...)
>   =E2=97=8F checkpatch.pl: board/apple/nxx-common/nxx.c:20: WARNING: Use =
the livetree
>  API (dev_read_...)
>   =E2=97=8F checkpatch.pl: drivers/serial/serial_s5p.c:16: WARNING: Use
>  'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' where possible
>   =E2=97=8F checkpatch.pl: drivers/serial/serial_s5p.c:65: WARNING: Use
>  'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' where possible
>   =E2=97=8F checkpatch.pl: drivers/serial/serial_s5p.c:123: WARNING: Use
>  'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' where possible
>   =E2=97=8F checkpatch.pl: drivers/serial/serial_s5p.c:140: WARNING: Use
>  'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' where possible
> ---
> Success: 0, Warning: 10, Error: 0
>=20
> The first CHECK uses a u8 so no side effects, the next CHECKS use a compi=
le
> time constant. About the livetree API, it looks like a false positive to =
me, as
> these fdtdec_* functions look like the standard way to init DRAM and its =
size.
> And the serial_s5p code essentially needs to not get compiled at all for =
this
> specific platform, so it uses #if IS_ENABLED(x) rathen than if (IS_ENABLE=
D(x)).

OK, thanks.

> So there were no spacing issues according to checkpatch.pl.

Yes, it's not really a good tool for that. Changes should be consistent
with the rest of a given file.

> FWIW, the PIE changes in arm920t/start.S and arm1176/start.S
> were directly copy/pasted from armv7/start.S and they are needed because =
the
> previous stage bootloader cannot be configured to load u-boot from a spec=
ific
> address. I'll fix the spaces without relying on checkpatch.pl to point it=
 out
> for me.

Thanks.

> > [snip]
> >=20
> > For all of these dts files, have you submitted them upstream?
> No, as there isn't a working Linux port for all devices. There is a kernel
> booting on 2nd, 5th, 6th and 7th gen iPod nanos, but from different branc=
hes
> because individual developers worked on each of the ports. But since gett=
ing
> u-boot to run is the easier part, and a pre-requisite for Linux, I decide=
d to
> wrap up and submit the u-boot port for review first.

OK. They should be able to be upstreamed in some manner, at this point
in time.

> > [snip]
> >=20
> > Can we figure out a way to share includes? It seems like this one for
> > example is cp'd a few times. Maybe arch-s5l8xxx ?
> I was relying on the arch/arm/include/asm/arch symlink that points to the
> corresponding arch-* folder at compile time. But since the files for all =
s5l87xx
> devices are essentially the same, I can modify the driver to just include=
 a
> common on in case of IS_ENABLED(CONFIG_ARCH_S5L87XX).

Thanks.

> > [snip]
> >=20
> > We should probably handle this as a "choice" statement
> I'll fix this.
>=20
> Does this also apply to arch/arm/mach-s5l87xx/s5l8702/Kconfig and
> eventually arch/arm/mach-s5l87xx/s5l8720/Kconfig, when it gets a second e=
ntry
> i.e. iPod touch (2nd generation)?

I suspect so, yes.

> > [snip]
> >> +#obj-$(CONFIG_S5L8730) +=3D s5l87xx-buscon.o
> >=20
> > Commented out lines should be removed unless there's a very good reason
> > to keep them (and in code, it should probably become some debug
> > statement that'll be optimized out normally).
> This code was an attempt to port arch/arm/mach-s5l87xx/relocate.S (Remap =
SRAM
> vectors) from ASM to C, but the vector copying needs to be done immediate=
ly
> after the remapping so I was not sure how to do it. I can leave just the =
ASM
> code for now and delete the C code.

OK. And yes, please remove stuff like that in general.

> > [snip]
> >=20
> > Empty functions like this should mean we just need to turn off a Kconfig
> > symbol instead.
> I've done it for the other CPU core types, but for ARM1176 there wasn't a=
lready
> a Kconfig symbol, and I saw that other platforms already do something sim=
ilar
> e.g.:
>=20
> arch/arm/mach-mvebu/cpu.c:47:
> void lowlevel_init(void)
> {
> /*
> * Dummy implementation, we only need LOWLEVEL_INIT
> * on Armada to configure CP15 in start.S / cpu_init_cp15()
> */
> }
>=20
> arch/arm/mach-hpe/gxp/reset.c:15:
> /* empty to satisfy current lowlevel_init, can be removed any time */
> void lowlevel_init(void)
> {
> }
>=20
> If the goal is to clean up this pattern, I can modify
> arch/arm/cpu/arm1176/start.S to include
> #if !CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT_ONLY), similar to the other ARM
> platforms.

Yes, there's a lot of places where the code can be cleaned up,
especially for these older cores, now that we've moved to Kconfig,
really. There generally speaking shouldn't be a need to add a dummy
function today, it just means some symbol should be off, or needs to be
able to be turned off (as part of migrating to Kconfig we did a lot of
"everyone seems to set CONFIG_X, so keep setting it, without seeing if
we could just turn off CONFIG_X and then drop some dummy functions).

> > [snip]
> >=20
> > I can see this (and presumably the rest) weren't done via "make
> > savedefconfig", so please do that for v2.
> They weren't as I didn't know this is the way to generate a defconfig. I =
will
> redo them using savedefconfig in the next patch.

OK.

> > --=20
> > Tom
>=20
> Thanks again for taking your time to review the patch. Should I submit the
> corrections as a new patch which applies on top of this one, or as a
> second version of this patch? Also I saw you have a GitLab instance, are =
MRs
> accepted there, or the email flow is the most recommended one? I'm more u=
sed
> to web-based MR and review, but I've already set up my email and git/b4
> tooling, so I can continue submitting the patches via email.

It should be a new iteration of the patch. And really, if you can split
things up more (say, a patch per generation) that might also make review
easier. We do have Gitlab, but email is how code is reviewed and
eventually picked up, rather than merge requests.

> Another thing to note is that I'm working on macOS so all building and te=
sting
> is done on a Mac. I also have a couple of Linux machines, is it a require=
ment
> to test if the patches build on Linux before submitting? I'm using
> arm-none-eabi-gcc version 16.2.0 from Homebrew for the target and Apple c=
lang
> version 21.0.0 (clang-2100.3.34.2) with target arm64-apple-darwin27.0.0 f=
or the
> host tools. It seems to work well so far.

It should be fine to keep working as you work. As documented at
https://docs.u-boot-project.org/en/latest/develop/ci_testing.html it is
possible to get a CI run done, when you're ready to try yourself, and
that can be helpful.

--=20
Tom

--fn+S73J9R2iSg8y5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCas6HmQAKCRAr4qD1Cr/k
CrZKAP4127XSLaIR7vi5Rp8q4rdm3vk5Wz2ccahQjA6AMvecKAD+KjmCrclPTlK1
OJXgeO/GXxeOcFnMElgOsODyQmq9eQQ=
=zneI
-----END PGP SIGNATURE-----

--fn+S73J9R2iSg8y5--
