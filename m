Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5FDC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:31:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DC8C606AE;
	Mon, 27 Jul 2026 09:31:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bBVML_8LX666; Mon, 27 Jul 2026 09:31:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6F80560673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785144708;
	bh=XcxgQ3RR+Pou/3gcBJMtzFs/SeZi/Xk5lMqviZeJ8Cs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d0Q3rVWHvwiSrEXoX9xxK7hZqba362pwzW3ENX2LibjTDRXcDn5LGXqzuFoIJczIK
	 M9AeakNKh4dkUb5BR/qTeX+BLPcFlmWmz+9AR64J/poXQVSS1vm2OE8Sa5kD6j4NRk
	 dq9NMKRWGg5DBaD6Lkv17TKg4KyQogmtGfg5nql2GYUBFapBMM/jRIdUpe7hx7d4PR
	 YzSJjvZ4vrP1nxKDapQ5CSXzoRAy2yGv5uHIcQnBG5Yc8MnNmGUoYjEN6L03rq5cBT
	 y+q8GeeXYCEZhwjranXf9yp9CZAD+Wv8ByfcK9Y629Mw3iSJmYQoDdrZv8Qu/qMfH9
	 OJ07Te5YTaTGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F80560673;
	Mon, 27 Jul 2026 09:31:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DBA9357
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:31:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 33FC280C63
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:31:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MQC5eeAoqdvi for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 09:31:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=igor.opaniuk@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2B99780C38
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2B99780C38
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2B99780C38
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:31:45 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7ea9c6ea7deso1607046a34.3
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 02:31:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785144705; cv=none;
 d=google.com; s=arc-20260327;
 b=hjI7xYHLEM7LEyrBRFymB0+PPRBDUaAcRzzK9C0mxjodQirzP6VLSngU4pS+R2+LAW
 Eetri5mDXmau0V4Lx8sSlmPSb/omC3rJ7FouyiuJ9uD2woEV5LqXTNZant7VSYjdHapt
 hQIIOWkfb8K+KALgFS8UYlGLMFP73HAhi3eo6lK/BOsPRcEWMsHmoz0uBmwLIFDJdpur
 Zagp3d0LWDu9PEQnXl08gu/E8/C+dcWTHbyKqaCY8b3J4dIQXE1WexqTLO7/A5pD6SOv
 RjpxOJlOfkoTgRj63TE/MIJmJL+IFCxKLku4TY10fx+WS6i3eLzscwQN8Giw67tHqq8X
 1RIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XcxgQ3RR+Pou/3gcBJMtzFs/SeZi/Xk5lMqviZeJ8Cs=;
 fh=x39pOo1VuSFSJW+zMRmpBrkzk+CcwcmoXE+Q4t1Vmgo=;
 b=KTiIljtI9/rUZ/sYnOSn6ZI0KzRLjLnDS48J/Jfa2GfhuLgAxD9j1hjzRnheFyQJF6
 UBcZsUWFRhr9MQUdPUYruZu5hkDsGV0T2Sj2eTXv5vKTHe3NGMwV3aYJBBOAtEQ15EzB
 BvAOvJE/cOw1GXIH2LluxiKa+e1TPVP+Let83oEdMgEvuzAKzV8e7JZM2qFqGvq1h7E9
 BfT2bsDBgAvqOHLP/e6/dkPY9oHu4zDqBUYTxrolVZFXYmNaI5nfLPO0UOfBmfapvQK5
 bAfVinzO81ztU/GehSdiqB48poalWB8MqOZA0FjOEnXcvVOFoh5foMkCyiReykY+a5EC
 evjg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785144705; x=1785749505;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XcxgQ3RR+Pou/3gcBJMtzFs/SeZi/Xk5lMqviZeJ8Cs=;
 b=aZhUkp+HWpD+anEsVsBZmsdGcdqcd1DBE900u5oOzigb9ic7UG1ybe1ls+mqpXe8xF
 Fsv8mn0VdhQ2cTf64DXY9Wu2T7U2R1KdqOjXzwIbAqkHwVl/x2iBJ3ODZI9LOs8M1eHZ
 pNqW1INFspK7EpZSetgH4eVt1OE2+hCGVrpYjN2UqT7PJsg68zdKuN7UWMTjUkyE4Wzq
 OOXq12nU1NyoKVjYOn2Whi2oxqCx9DIMucIDumFm8SZE+o5um1MNUcTB9i32kEJaVv2c
 idRH3VykZDV/cmcW+xEu7Q7VFt3I46XRjZ4M5sxOEDliK23Waln/0uWVjeuQcggYyza2
 GbGw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqVWlnjai8VtGjAf1h2eADZu4FTFHGz8bitRab16uWyL/DN9jYZheXdY/UqTpPs0xA7uLd3PHc=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxXuo46jh9yOk0R1XFTKq0s/rTHhFVRRv99NYEiYSKlYfH66wI7
 1V3kW5n0RrPvjEWudFBNJJXE2T8s4l+WQML247+UdQB+F+heA3hc2+u7XwNxcFSbFFu1hpNeKvi
 bfrGv+PrhcXrzDBeSNWt2shaTdAgGwSSl+6i4
X-Gm-Gg: AR+sD10wvJdZgBBGuYh9Wg2eAyAfsdt2BEtw7GVO/Tc5OrfxGDhdTkqaYwXeAS/ieX6
 KITNbPD54ezs/faIL8THNpwz0R9SMDA/y6fnMnrpkGf9dm3kt5tig3PcjsxsGdPI83wFPIgG3aL
 rVxe/p7wfQj9SOAghrRY+30u5emcLY01DDTTe2EFlj8f7gn14cjtkL9fl1wrnHPzwteNCfphipc
 xbURknkljsAy7yVx16QHc0eqntacLfHKG9I7UuFTSl4y1X3QRliRuWb0iZ2bEaL+zJAucIuMP1H
 PxTm7/ke20DMo2vSb6o=
X-Received: by 2002:a05:6830:4987:b0:7e9:e9a0:9a8b with SMTP id
 46e09a7af769-7eff03f8556mr82282a34.16.1785144705067; Mon, 27 Jul 2026
 02:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260712-avb-libavb-1-3-v1-0-44a50dfe2f23@gmail.com>
 <178489889597.185493.15058174427127039022.b4-ty@b4>
 <87fr147uhj.fsf@kernel.org>
In-Reply-To: <87fr147uhj.fsf@kernel.org>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Mon, 27 Jul 2026 11:31:33 +0200
X-Gm-Features: AUfX_mwyWV8t4smShDb_icHxq6lbmzKUys0pbhpOkP61DzdVWyfTNfgA1AsQjIM
Message-ID: <CAByghJa1mEZhAMTr7C-1QcP4+2T458CcE3yX8JD5RpW5223PTA@mail.gmail.com>
Subject: Re: [PATCH 0/2] libavb: update to AOSP 1.3.0
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785144705; x=1785749505;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XcxgQ3RR+Pou/3gcBJMtzFs/SeZi/Xk5lMqviZeJ8Cs=;
 b=L59rTobYvoTjO3OwEcFF1fZ14FF/C021K/MPX3Wo0wuc+/U58ts9NjagR2pnZwq06z
 7RScqDdPjUZlKwKP4E5j5PEV426ygyBPkASihEK9P33BnKUuDe55fswsDWiVv/txkz7M
 O/+0dhureV2S7V/QF9wzR8aRhrZ4V7oOEgxzRDkzkeN1/Ko8Yyo7xm76SweX66hFgEvt
 iN/qzngxWTkjWpa2B2YUTWfMn19nUX7DG7wPkbosKH37xIQpvQ7UyFchw3FbSvrZyTY9
 nUIukalqbypEQ8PTz7BozKCCtn3cQKKHYu0b9eauOcXz2fYj3iWfmUvOMVnolm30eD5a
 WAOg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=L59rTobY
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

Hi Mattijs,

On Mon, Jul 27, 2026 at 9:38=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>
> Hi Igor,
>
> On Fri, Jul 24, 2026 at 15:14, Mattijs Korpershoek <mkorpershoek@kernel.o=
rg> wrote:
>
> > Hi,
> >
> > On Sun, 12 Jul 2026 16:07:09 +0200, Igor Opaniuk wrote:
> >> The vendored libavb under lib/libavb/ has been frozen at a ~2019 AOSP
> >> snapshot (AVB version 1.1.0) for about six years. A v1.1.0 library
> >> rejects any vbmeta whose required libavb minor version is greater than=
 1
> >> with UNSUPPORTED_VERSION, so an image signed by a newer avbtool that u=
ses
> >> a 1.2/1.3 feature fails to verify. This series re-syncs the library to
> >> version 1.3.0 and picks up the accumulated upstream fixes.
> >>
> >> [...]
> >
> > Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-b=
oot-dfu (u-boot-dfu)
> >
> > [1/2] libavb: update to AOSP 1.3.0
> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/com=
mit/963ec1af8a4b6d5d185ad289dbb0178ef2199d5f
> > [2/2] doc: android: refresh AVB provenance and pin libavb reference
> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/com=
mit/f8aba1d9c54c19a7c863bd5b4d035aa46a10bab0
>
> This seems to break sandbox build/test. See:
> https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/jobs/48391
>
> Some relevant part of the logs:
> $ tools/buildman/buildman -o ${UBOOT_TRAVIS_BUILD_DIR} -w -E -W -e --boar=
d ${TEST_PY_BD} ${OVERRIDE}
> Building current source for 1 boards (1 thread, 112 jobs per thread)
>    sandbox:  +   sandbox
> +lib/libavb/avb_cmdline.c:371:48: error: a function declaration without a=
 prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
> +  371 | AvbCmdlineSubstList* avb_new_cmdline_subst_list() {
> +      |                                                ^
> +      |                                                 void
> +1 error generated.
> +make[3]: *** [scripts/Makefile.build:272: lib/libavb/avb_cmdline.o] Erro=
r 1
> +make[2]: *** [scripts/Makefile.build:497: lib/libavb] Error 2
> +make[1]: *** [Makefile:2210: lib] Error 2
> +make: *** [Makefile:189: __sub-make] Error 2
>     0    0    1 /1              sandbox
>
> Could you please send me a fix for this?
> If not, I'll have to drop the patches from my tree in a couple of days.
I've sent v2. Thanks for reporting the issue.

>
> Thanks
> Mattijs



--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk
