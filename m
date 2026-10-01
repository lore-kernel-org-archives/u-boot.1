Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC24CA5FCF
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 17:31:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5558D81274;
	Thu,  1 Oct 2026 17:31:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YO9px3M1-xrt; Thu,  1 Oct 2026 17:31:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0D96081235
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790875866;
	b=eRN9vM9ctje1RO1aKsW4hgWwpWFyRI4v93qHC0fjjSeqSGtNStyCZsIsYwZiHAd0gAGo
	 IFRbaN3+akAKj6Yf8ADfiylLbvUW1KmcyibzdaMtCogz5w+ICG/AcMgImWlytkZqY5Hun
	 Lc5CInVXKCnW2RxvEPt6pKIRFV4cFrFGrQ1acurzNeMQoM595tGqDZlFrI7utRWpfWqIf
	 Zd2b7qZYPXo6Zoiu+mgNqdQaiyEU+DqGLP50vHJS1DUFB+1p9Hq+sUTpCgzNgnq62m8q2
	 jX7gfTE7o3u9+qN2qhPOir4fjZ30TW0HB+xSaQ6QyIlGeJnJhTRHuWZgQElm310OqgA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790875866;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AawtW0tmLqLFwrC4mAJvJS9nuCcORPF54On1U2rnOo8=;
	b=ErNSpEWIeAdS+tns7PkqzuGbPQsarmbBeaPd/QdoK3rcUgEKmyONMaCb4m7jYGq4NNdt
	 SUBHXaZjHhbNFdYxiIsye+dIXtBNfI7DNoDlnZ/EYhVfy+beBMrXCJ9Pv/LpEZJ91TRo8
	 VO2smU9NsrAaYyEmsbUNPzyav+HFiv2rVfPrdHvDqSGb5AVyPGhRdl3eh1jLirI4oJsAo
	 t2Wf77ZaFCBvAXbc9WGmHo1zXkR+y2WwtCVJi9PcAOa2LenBX04PFQvs3lyQByMrmZUh2
	 CJowU5Sbf6DXWMnF5eZ5/00wX95ZSVSqlJtClnt7VXymsJZmdQPzIBQMcL0JPRgwEWQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790875866;
	bh=AawtW0tmLqLFwrC4mAJvJS9nuCcORPF54On1U2rnOo8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g6V8Ls8JosXiQzeDYiFpYy9epxSwi5XOdX02xqD4tVj5fvua9VvosrAA5U8wHQktV
	 HBIcLSsHPikjq7QXy7UkUkbgcZAf2GtWSijdJhfZRyfwKnUY/eLP2YY4b+32f0jVd7
	 2/OuoVxJVEYkaEPXMVQ/3K9ujDykkPxi5QUZcC802ytjLG0S5FMG/zqNIlWYnqofSY
	 +kZr6siIwPmpthbzvzAPEmDFoCSEGAxmRinYp18wZUAi9I4HkQGZ3KVU9uvKvwXgJD
	 EIZ22cGMehF3v1XrNcpYpJp3VPOoB8/gwG4DWhG3N6oDTfxsKO9o7PkMY7z3uSe8+A
	 LADq6YGXX6UXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D96081235;
	Thu,  1 Oct 2026 17:31:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 558AF32F
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:13:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4601C40AB8
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:13:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cAbvmApb2MJr for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 16:13:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2827740AB4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790871207;
 b=qlDVDjEORsFbJmvDhqJ0M9Axai7KBCaf26GkLBReUCEihncDyCQM1nVPbijTz3JTBfXy
 p1FN8Q5Kjm8QIY5AElmU100fRas87SpzSIAgQYKYesHizt6HyNFEqUW5TbSX0+tcwuKcG
 fuuis0dKG992psCradIsyQW60dEsz50mtuEWgI8cihvXQqTykZR8j8T8Y7lp8NW6/E39L
 YXlblqVswlgx8MQnprvHz7z38FlHaq/CW5NiExdswuPDbr41dnrpEIsbrL+B7A30h6FGP
 UqtZWDDRB67yW5BF8cKm3s4Xd6K6kNkVEJZhULuyNBe59QAG8z90PjtGEoF1R/tQH1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790871207;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=AawtW0tmLqLFwrC4mAJvJS9nuCcORPF54On1U2rnOo8=;
 b=CaMQgBvIyqVE/+d8/SWebZahBvN0qGh4HbQz1NgF4DKFA7uIsmWmCroMFQGJsqCm3H35
 rrByAOw8BTfuebfsXAC1p1aUFYxNBM2LlpaqONLmQtpNkf6IPuQNgMi83mVrTZVvUPhh7
 +L/Ixu5FLOiYbT+TrUphavbnkOggjutDg2cuNg4UWSIXab0rRAHAJ9nPrjhqyPBMMS87h
 w3UILhxSzmm0LSIF6Jh1PtNlPNSIgpuyf7Okqh3EGgL2iOH5gqtLSkeMuemFhimC1Y6Iq
 nqy+zeeVteVE0eyLuHPuPfYh3zee/Ogzu7XaDafCQkHqA5SNIRDZazQyjZsgHpkbO8Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=UrUcyDAF; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::f;
 helo=mail-ej2-x0f.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=UrUcyDAF
Received: from mail-ej2-x0f.google.com (mail-ej2-x0f.google.com
 [IPv6:2a00:1450:4864:34::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2827740AB4
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:13:26 +0000 (UTC)
Received: by mail-ej2-x0f.google.com with SMTP id
 a640c23a62f3a-c2e201b7189so344652766b.0
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 09:13:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790871204; cv=none;
 d=google.com; s=arc-20260327;
 b=etxzWtj8VKM38RExH621QKdstCVGEpiS+pB18xNTK9NZ4SPlswCsFxClDM1nOGZ987
 DutTvI+7d9yroNk/YJgGQhXSU2YmnI9HaQQ6JStxzig01oAI+SKTS8tVLEx1MitDZMDQ
 PJFhSTpjJ1ZUibG4lKSoHQ6urVBOID82CDyB5R34p/iaZvtfi38keejmHwy3Sieu/WIa
 o+UcyNpDEsxBigk73wWHn8Ibjbx6N3zwXYSOm132ZLg59rPxFZmg8Gvagnbv0I3bZKEM
 gjVv7lQKLmyrnWE3W5E37+PLoCUkog6SOGzvZ0POH6JkOZIf1I6ooIkh+B/6/YUgXuO7
 6alw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AawtW0tmLqLFwrC4mAJvJS9nuCcORPF54On1U2rnOo8=;
 fh=6u0daoMOtob1j5ALv+m+jRWj8DIyCvpxakbi/4sk8NI=;
 b=jT0s5rRgxMSc0QDzz4vuu8nYRRZDPaTv2n2Iqrdhmlri97t6qz57xlbLdX472apVYT
 Vc4Ka/h2ljqljdtVWDINRRBUQoFhvQzvuG7Lodz49OA7l2PHn0UlhsJj3hi0rfa2b7FQ
 ewIcF0KhbOvViMT6GykIN5Uym+BfbCAJyc2fupycsX+ePn09T4lfliSvv+nb81cVdEO7
 WbY0BZeAi/Tnwq4OoG3gLIlHrwTUceJrmesHXrl2ETXa/0iEEXDrPKFt0PrzeGy2mGtF
 IpE6UjbFteIuJPt84+pYM6Ncjk5cE27V8QsC0B/ClYHPmfuKEpe6DCS1pWjq9xg26Nhx
 xdTQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790871204; x=1791476004;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AawtW0tmLqLFwrC4mAJvJS9nuCcORPF54On1U2rnOo8=;
 b=UrUcyDAFpUtzLMfX6vKML7Zajq/aC6BszB/ouuHvXrwe+L+da7a9dU8zy+g0xmokiu
 KzQVveVGJLKi3ONU8G4bV/b+ZzTFcyIAPmBGTFGpDtLP4SneVPrkm/TLl1Ui8cWBdJ69
 UUaX25VwtddrTHpfwLqAt2v4S8qIHcMXKbIXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790871204; x=1791476004;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AawtW0tmLqLFwrC4mAJvJS9nuCcORPF54On1U2rnOo8=;
 b=ICDeOl/1kROSDFASIh2urkhC3yof8eLT6gG69jfwdL9S36HEQrJQboFCW16G0NbCgS
 p4QCHMgEjwnjzlkC1R15OvmRcgCQtWGJyNRfSxDx9Hr5Wgg2lEVCHqIUN41BAtVHc7r+
 1FUeX9xRGz9fPSiN/VtBjwIwlCtNJ/V3qgUxPg6Ehn5ocjTxoZy3S+zUFuvzwgt3ygrZ
 moNca+7i2zHs5TYoqtDMgBNClyhK5J1Zu/MkPEZS0lQ4OhogdjkTcYejEhDdvwTD9X0F
 oWoisDCno1S9JxUdESbycy5Fh4J8R0Qhs9hX4BP1XOq7pRIf74ISwSPEMz8ltxzpmSlj
 M7EQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBys9yXmhBJyapwLdYb8MWpLwvfvEYSmFwSjCVnJGSJaEyT/3tcXgB48ysIBTArxGrPwpdtW3Ho=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lpnj1MAdEf/7mE9Dy+PCTVPsNvyAdCXXDkWDYnROy/6JBeLj8I
 IXyWIcHdUhw/Q24nnSVCFuZOK0pRxxNIdQODaSS1LV2sLy187OHzuGEdEqrk/yPRxtL4H6otnRL
 t+YmG5OpTeALAzmiRAG7dnxbIz2NzStACZDnOBLUt
X-Gm-Gg: AYBFou3AOvkm9UH2TKvHbind1ZzFUdorXD3zaOGuxE8i6dHfqSY/KNYCMLqdxObgIqs
 dCOq3CYde5BLlLhlXFGCXnaMvSQIs0WTea47txK8fS+lvAcW0ybEWYxJj/yRCWVgi+5ocnAcUE2
 vuXcmJEkOdldYTovEAsKGPv3tUwUJTPq/yxZ9NrCxd4glJZcLFYu9TuM7ghkCv7rnw9AouwlhEH
 qXCwSlXr28ZVkjsJRMoNAW7MYk1BZJU/OOjN5vfbxxkFdnr3iJU91ZlAgdyHeFiZuApfcufnkJA
 nFbKSrK/c42RV5VexaLdWpJTWeEikhhG9qdBjLXn/NjBhJWXPdRQCCoj
X-Received: by 2002:a17:907:a08c:b0:c2d:c7df:50be with SMTP id
 a640c23a62f3a-c2e4afb5a9dmr4539066b.34.1790871204395; Thu, 01 Oct 2026
 09:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-6-acb97c172993@flipper.net>
 <00e2291d-7fc5-4ea1-abb2-9b9100a2b680@cherry.de>
 <CAKTNdwFMCK2frVyrmYWe67k6WgjA7pmJn-SbU+_9NtceHqHERw@mail.gmail.com>
 <6ea99943-eb9d-43a8-a238-edbc1b9c767d@cherry.de>
 <CAKTNdwELO46dZ1Cy+-wpBbQNsP9XJyTgCjBYLQpE39YJ3XP0wg@mail.gmail.com>
 <e7235ec1-dff2-44fa-8c02-9b6a1012bba6@cherry.de>
 <CAKTNdwEgVRZVFr+V8jCwQmJES7PO3WgdBa5es4EkkOy50xdkiw@mail.gmail.com>
 <1cc78fcf-bc97-42bb-ac67-792ad047adc0@cherry.de>
In-Reply-To: <1cc78fcf-bc97-42bb-ac67-792ad047adc0@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 17:13:12 +0100
X-Gm-Features: AclHuK_go9rzog1cBgwC6Qb3lu74CVPswHT1_sag8TibbnMVy8o_1tWN0zcOdLQ
Message-ID: <CAFLszTi_8=bK=gLEEadunTLumaGo8L8enYovxFadCyzPXorJiQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] binman: Add support for pre-patching FDTs in a
 FIT with a /chosen node
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrew Davis <afd@ti.com>, Hrushikesh Salunke <h-salunke@ti.com>, 
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
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 01 Oct 2026 17:31:04 +0000
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

Hi,

On Tue, 29 Sept 2026 at 13:03, Quentin Schulz <quentin.schulz@cherry.de> wr=
ote:
>
>
>
> On 9/29/26 1:03 PM, Alexey Charkov wrote:
> > On Tue, Sep 29, 2026 at 2:29=E2=80=AFPM Quentin Schulz <quentin.schulz@=
cherry.de> wrote:
> >>
> >> Hi Alexey,
> >>
> >> On 9/28/26 6:44 PM, Alexey Charkov wrote:
> >>> On Mon, Sep 28, 2026 at 7:53=E2=80=AFPM Quentin Schulz <quentin.schul=
z@cherry.de> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 9/28/26 4:03 PM, Alexey Charkov wrote:
> >>>>> Hi Quentin,
> >>>>>
> >>>>> On Mon, Sep 28, 2026 at 5:26=E2=80=AFPM Quentin Schulz <quentin.sch=
ulz@cherry.de> wrote:
> >>>>>>
> >>>>>> Hi Alexey,
> >>>>>>
> >>>>>> On 7/31/26 7:10 PM, Alexey Charkov wrote:
> >>>>>>> When a generated FIT is used to boot Linux directly, bypassing U-=
Boot
> >>>>>>> proper (Falcon mode), there is no runtime code to discover the ke=
rnel
> >>>>>>> command line and (optional) initrd location and include them in a=
 FDT.
> >>>>>>>
> >>>>>>> To facilitate easier preparation of a ready-to-boot FIT, add supp=
ort for
> >>>>>>> pre-patching the FDTs in a FIT with a preconfigured /chosen node =
including
> >>>>>>> the bootargs and initrd location.
> >>>>>>>
> >>>>>>
> >>>>>> This sounds wrong to me. Why should we hardcode those at build tim=
e? We
> >>>>>> already do DT fixups in U-Boot proper *at runtime*, so we should
> >>>>>> probably do the same in xPL when booting in Falcon mode instead of
> >>>>>> hardcoding stuff. Since you're aware of this, I'm guessing you dec=
ided
> >>>>>> against, but you don't tell us why. I'm a bit worried going with t=
he
> >>>>>> suggested implementation means we'll eventually have a binman node
> >>>>>> property for each DT node/property we want to write/override.
> >>>>>
> >>>>> The "regular" Falcon way of doing things (i.e. the one not involvin=
g
> >>>>> TF-A) has so far been: "capture what U-Boot patches into the args t=
o
> >>>>> be passed to the kernel, package it into a fixed binary, and boot o=
nly
> >>>>> that". No runtime fixups. So I more or less followed that pattern, =
but
> >>>>> tried to make it a bit more accessible by eliminating the "capture
> >>>>> something at runtime and save it somehow somewhere" step, which I f=
ind
> >>>>> unnecessarily painful.
> >>>>>
> >>>>> Maybe runtime fixups could be brought into xPL, but they are
> >>>>> excruciatingly slow, whereas speed is the main reason for wanting
> >>>>> Falcon mode boot in the first place. Right now with Falcon mode on
> >>>>> RK3576 I'm getting 2.5 seconds from applying power to _userspace_
> >>>>> (i.e. full graphical UI drawn on the screen), whereas the best I co=
uld
> >>>>> get with U-Boot is just over 3s to its boot menu, much of that time
> >>>>> spent going over the flat devicetree before relocation in O(n^2)
> >>>>> passes. And those 3s are after stripping the massive pinctrl node w=
ith
> >>>>> hundreds of its always-present children from the pre-relocation DT,
> >>>>> which alone saves ~0.4s.
> >>>>>
> >>>>
> >>>> Are they always present, even with /omit-if-no-ref/ instruction? Or
> >>>> maybe you're building the device trees with -@? Trying to figure out=
 if
> >>>> somehow we have a bug in dtc (or in our scripts making use of it).
> >>>
> >>> The problem is that there are a lot of `status =3D "disabled";` devic=
e
> >>> nodes referencing pinctrl nodes, which keep dtc from dropping them
> >>> altogether, so a lot of unused pin configs end up in the binary -
> >>> enough to be noticeable in boot time.
> >>>
> >>
> >> And we cannot really get rid of the status =3D "disabled" nodes as the=
y
> >> may be switched to "enabled" for some reason at runtime by e.g. U-Boot=
 I
> >> guess? I'm wondering if this (stripping all nodes which are disabled) =
is
> >> something we could still allow (e.g. gated by a Kconfig symbol).
> >
> > Yes, stripping those entirely would break DT overlays and runtime
>
> Base DT for overlays need to be compiled with -@ so you have all symbols
> available, this is something we could detect (presence of /__symbols__
> node IIRC) and bail out...
>
> > board fixups (e.g. what I do for the Flipper One to switch between
> > SATA/PCIe pin modes based on the M.2 key B config pins strapping).
> >
>
> but that would also prevent that kind of things and since you actually
> are already impacted by this, the hack I suggested isn't appealing anyway=
.
>
> >  From what I understood while investigating those boot delays, it's the
> > linear FDT representation in (uncached) pre-relocation memory what
> > kills performance when the count of nodes grows to real-world numbers.
> > Having a more efficient data structure to hold the tree
> > pre-relocation, or enabling D-cache pre-relocation, would both speed
> > it up considerably - perhaps more so than trimming the tree itself.
> > But going down that road sounds a bit scary.
> >
>
> No experience with cache so big scary word to me indeed ;)
>
> >>>> Don't we have FDT and DM in SPL anyway as that's how we probe driver=
s in
> >>>> that stage (not counting the few SPL-only boards we have)?
> >>>
> >>> SPL's DTB is tiny due to bootph-* markup (it was just 27 nodes last
> >>> time I counted for my RK3576 use case). Making SPL parse the whole
> >>> OS-oriented device tree, along with all the relocations required to
> >>> insert stuff at runtime, will hurt.
> >>>
> >>
> >> Ah yes, missed that.
> >>
> >>>> I don't have anything better to suggest, I'm just really worried abo=
ut
> >>>> the potential ballooning of properties we need to mirror in binman.
> >>>>
> >>>>>>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >>>>>>> ---
> >>>>>>>      tools/binman/entry.py     |   8 ++++
> >>>>>>>      tools/binman/etype/fit.py | 103 ++++++++++++++++++++++++++++=
++++++++++++++++++
> >>>>>>>      2 files changed, 111 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/tools/binman/entry.py b/tools/binman/entry.py
> >>>>>>> index ce7ef28e94b1..e0dea8bf3a49 100644
> >>>>>>> --- a/tools/binman/entry.py
> >>>>>>> +++ b/tools/binman/entry.py
> >>>>>>> @@ -636,6 +636,14 @@ class Entry(object):
> >>>>>>>              self.Detail('GetData: size %s' % to_hex_size(self.da=
ta))
> >>>>>>>              return self.data
> >>>>>>>
> >>>>>>> +    def GetNode(self):
> >>>>>>> +        """Get the devicetree node which describes this entry
> >>>>>>> +
> >>>>>>> +        Returns:
> >>>>>>> +            Node: Node for this entry
> >>>>>>> +        """
> >>>>>>> +        return self._node
> >>>>>>> +
> >>>>>>>          def GetPaddedData(self, data=3DNone):
> >>>>>>>              """Get the data for an entry including any padding
> >>>>>>>
> >>>>>>> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.p=
y
> >>>>>>> index 32caa03a7e16..750ff5b47ed5 100644
> >>>>>>> --- a/tools/binman/etype/fit.py
> >>>>>>> +++ b/tools/binman/etype/fit.py
> >>>>>>> @@ -304,6 +304,40 @@ class Entry_fit(Entry_section):
> >>>>>>>
> >>>>>>>          See :ref:`fdtgrep_filter` for more information.
> >>>>>>>
> >>>>>>> +    Patching /chosen into the generated device trees
> >>>>>>> +    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>>>>> +
> >>>>>>> +    When the OS is booted directly from this FIT (e.g. Falcon mo=
de) U-Boot
> >>>>>>> +    proper never runs, so its usual runtime /chosen fixups do no=
t happen. Two
> >>>>>>> +    optional properties on the `@fdt-SEQ` node make binman patch=
 each generated
> >>>>>>> +    device tree at build time:
> >>>>>>> +
> >>>>>>> +    fit,bootargs
> >>>>>>> +        A string written to /chosen/bootargs of every generated =
device tree
> >>>>>>> +        (any existing value is overwritten). Typically set to `C=
ONFIG_BOOTARGS`
> >>>>>>> +        via the preprocessed devicetree source.
> >>>>>>> +
> >>>>>>> +    fit,initrd
> >>>>>>> +        The image name of a loadable (e.g. "ramdisk") to use as =
the initramfs.
> >>>>>>> +        Its `load` address and packed size are written to
> >>>>>>> +        /chosen/linux,initrd-start and /chosen/linux,initrd-end =
(at the width of
> >>>>>>> +        the device tree's root #address-cells) and reserved in t=
he FDT
> >>>>>>> +        memory-reservation map, mirroring fdt_initrd(). If the r=
eferenced image
> >>>>>>> +        is absent or empty (e.g. an optional initramfs that was =
not supplied)
> >>>>>>> +        the initrd properties are omitted.
> >>>>>>> +
> >>>>>>
> >>>>>> This sounds wrong, why would the FDT image node need to know about=
 which
> >>>>>> ramdisk may be used? Shouldn't we rather have a ramdisk property i=
n a
> >>>>>> configuration node, and then patch the FDT based on that informati=
on?
> >>>>>
> >>>>> Falcon mode boot where these are useful is for a fixed-configuratio=
n
> >>>>> boot flow anyway, where one wouldn't have a way to select among
> >>>>
> >>>> How do you plan on doing A/B with Falcon boot? How do you know from
> >>>> which partition the kernel you booted originated so you don't upgrad=
e on
> >>>> the currently booted partition? There must be some way for U-Boot SP=
L to
> >>>> tell the kernel at runtime where it came from?
> >>>
> >>> I don't currently do A/B with Falcon; instead, I rely on the fallback
> >>> to U-Boot, and U-Boot in turn loads from a UFS boot W-LU (which is A/=
B
> >>> native). Making A/B work with Falcon would be a nice follow-up, but I
> >>
> >> This means supporting two completely different boot flows with potenti=
al
> >> side effects (U-Boot proper probing/breaking stuff while Falcon mode
> >> doesn't).
> >
> > Yep, not ideal. It's all heavy work in progress, so I might still
> > rethink the whole approach more than once :)
> >
> >>> believe it will require some external metadata to choose the active
> >>> boot source anyway - and then the same external metadata can be used
> >>> for the upgrade. Such as the UFS device attributes, or whatever peopl=
e
> >>> use for RAUC and such.
> >>>
> >>
> >> I guess you could use a U-Boot environment for that or some more secur=
e
> >> location (via OP-TEE/TPM, etc...).
> >
> > RPMB with the key managed via OP-TEE backed by hardware secure OTP and
> > on-chip crypto would have been great, but it's a mighty detour from
> > where we currently stand, so I'm leaving that for desserts :)
> >
> >>>>> several ramdisks to go with the kernel image. So putting this
> >>>>> information directly where the user (i.e. the kernel) will find it
> >>>>> cuts out intermediate steps, which in turn improves speed and reduc=
es
> >>>>> complexity.
> >>>>
> >>>> You already have:
> >>>>
> >>>> fit,firmware =3D "atf-1", "kernel", "ramdisk";
> >>>> fdt =3D "fdt-SEQ";
> >>>>
> >>>> in the configuration node. So simply have binman derive from
> >>>> fit,firmware which node is included of type "ramdisk" and fixup the
> >>>> device trees in fdt-SEQ based on that info? Less user-prone IMO.
> >>>
> >>> Ah, I thought you were referring to runtime FDT fixups based on the
> >>> selected configuration. Patching it in using binman based on the
> >>> configuration node contents should work, too, but what's the practica=
l
> >>> benefit? It would still use the same ramdisk node, just written in a
> >>> different place - or am I missing something?
> >>>
> >>
> >> Not written in a different place, written in the only place it already
> >> is, removing the need for duplicating the info which the user shouldn'=
t
> >> have to do.
> >
> > I think I start getting what you mean, let me see if I can indeed make
> > binman infer which "ramdisk" should go for "ramdisk" and write the
> > attributes based on that :)
> >
>
> I'll try to be more concise/explicit next time. Trying to review too
> many things for different projects at once at the moment so I sometimes
> just do "brain to fingers" without putting much more thoughts into it.
>
> >> Re: fit,bootargs, can't you simply have the property included in your
> >> -u-boot.dtsi directly, so we don't have to have yet another binman
> >> option? I understand this won't work well if we separate binman from
> >> U-Boot like talked in a different thread, but we are not there yet.
> >
> > That would mean rewriting the .dtsi every time the bootargs need to
> > change, which in this setup is just an (already existing) Kconfig
> > option. The property is also not useful for U-Boot proper, which would
> > inherit it via -u-boot.dtsi. Plus, I'd rather not make the whole
> > Falcon thing too board-specific, as then it makes trying it out on a
> > different board way more pain than strictly necessary.
> >
>
> You could reuse the Kconfig option in the dtsi. But ACK, no perfect
> solution it seems so far.

A few vague thoughts:

1. If binman finds the ramdisk from the configuration, note that an
FDT image can be shared by several configurations with different
ramdisks (or none). In that case there is no single correct /chosen,
so binman should probably raise an error rather than letting the last
one win.

2. To avoid adding a binman property for each fixup, how about
allowing a 'chosen' subnode in the FDT image node, whose properties
are merged into each generated DTB?

       @fdt-SEQ {
           ...
           chosen {
               bootargs =3D CONFIG_BOOTARGS;
           };
       };

That keeps it out of U-Boot proper's DT and still comes from Kconfig.
The initrd properties would then be the only special case. We would
need to update the FIT spec.

3. We don't support decompression for ramdisk - linux,initrd-end and
the memreserve use the packed size, so it  might be nice to have a
test to ensure U-Boot rejects that.

Regards,
Simon
