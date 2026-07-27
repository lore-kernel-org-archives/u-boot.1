Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06BCC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 12:30:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8D0C80D3F;
	Mon, 27 Jul 2026 12:30:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x4Mg-lkyoWRp; Mon, 27 Jul 2026 12:30:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C980E80DE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785155429;
	bh=Sh6D5MekyMend3RNkacH6qLfNLnqC4Qc5dW8csfSemg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NBTgOEVGlzvD3JD+LVYOaJF0LA0DuF+5Cbkoh/ZKd2fRXLWsiPvb8ulXQWq40Disv
	 eL2XEXOJLCHq1OeDko5tdzlntCCiwTXEmOr4FbV9rtaUDcfLpebQ8h6fug5G34zUh6
	 GOLqQeNuDcUHG8NV/4bCeIRoLBf/pN4jJzzsLS7jzr5RzJZwwysyNjWc45IVm+rsWS
	 YqKj4gpgCFHRvkd3MU+uHtQ7enRr8o1gC+8Ss7Rp3HsIt8pnrcNW1XXxYFBwVEsd0p
	 7lJdd2hRQ8jj1URhEKT7zhf/E9HHZcmXuCl2uaykpD3MvgeoiEHXeNpE9po6mHFHXH
	 HBxeUCvKXTDeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C980E80DE6;
	Mon, 27 Jul 2026 12:30:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BBAA7357
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:30:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AD26A4006A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:30:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UJaguy6ZaxIL for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 12:30:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 996FF40015
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 996FF40015
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 996FF40015
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:30:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5C04B4233B;
 Mon, 27 Jul 2026 12:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72021F00A3A;
 Mon, 27 Jul 2026 12:30:26 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 0/2] libavb: update to AOSP 1.3.0
In-Reply-To: <CAByghJa1mEZhAMTr7C-1QcP4+2T458CcE3yX8JD5RpW5223PTA@mail.gmail.com>
References: <20260712-avb-libavb-1-3-v1-0-44a50dfe2f23@gmail.com>
 <178489889597.185493.15058174427127039022.b4-ty@b4>
 <87fr147uhj.fsf@kernel.org>
 <CAByghJa1mEZhAMTr7C-1QcP4+2T458CcE3yX8JD5RpW5223PTA@mail.gmail.com>
Date: Mon, 27 Jul 2026 14:30:24 +0200
Message-ID: <87o6fs399b.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785155427;
 bh=Sh6D5MekyMend3RNkacH6qLfNLnqC4Qc5dW8csfSemg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=KdY9fD1KIsfv8TL/f9Vrlkm1y3quYvWimH7oQGgjwak7EEFOcXbew0OowybHObGbW
 S4OxxhYl/pE7OuSdQufSimzuhiXYE206t99mDX3yOnrrgKhLgF3NPhwr2qIfY6k261
 ++uaanFLaAfWH5rG8raKF1g9fTrEKQFnW5Ibf7qKAEecimkEY4cElIbJkrd2ZLZGLY
 5vSq6lwEROBCPvFnHsgNY2xNSm+0qmBd4FFdRDA61Os+HtrGuc2NkJ5C+JZeosJOY9
 OQZyRJajP94tHDAFFPMzt+VFCjrXNqTNX2yUMXr60AvFUffUNuZtAHlv3HeFGZK55Z
 UeZObbGQDvOQw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KdY9fD1K
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

Hi Igor,

On Mon, Jul 27, 2026 at 11:31, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:

> Hi Mattijs,
>
> On Mon, Jul 27, 2026 at 9:38=E2=80=AFAM Mattijs Korpershoek
> <mkorpershoek@kernel.org> wrote:
>>
>> Hi Igor,
>>
>> On Fri, Jul 24, 2026 at 15:14, Mattijs Korpershoek <mkorpershoek@kernel.=
org> wrote:
>>
>> > Hi,
>> >
>> > On Sun, 12 Jul 2026 16:07:09 +0200, Igor Opaniuk wrote:
>> >> The vendored libavb under lib/libavb/ has been frozen at a ~2019 AOSP
>> >> snapshot (AVB version 1.1.0) for about six years. A v1.1.0 library
>> >> rejects any vbmeta whose required libavb minor version is greater tha=
n 1
>> >> with UNSUPPORTED_VERSION, so an image signed by a newer avbtool that =
uses
>> >> a 1.2/1.3 feature fails to verify. This series re-syncs the library to
>> >> version 1.3.0 and picks up the accumulated upstream fixes.
>> >>
>> >> [...]
>> >
>> > Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-=
boot-dfu (u-boot-dfu)
>> >
>> > [1/2] libavb: update to AOSP 1.3.0
>> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/co=
mmit/963ec1af8a4b6d5d185ad289dbb0178ef2199d5f
>> > [2/2] doc: android: refresh AVB provenance and pin libavb reference
>> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/co=
mmit/f8aba1d9c54c19a7c863bd5b4d035aa46a10bab0
>>
>> This seems to break sandbox build/test. See:
>> https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/jobs/48391
>>
>> Some relevant part of the logs:
>> $ tools/buildman/buildman -o ${UBOOT_TRAVIS_BUILD_DIR} -w -E -W -e --boa=
rd ${TEST_PY_BD} ${OVERRIDE}
>> Building current source for 1 boards (1 thread, 112 jobs per thread)
>>    sandbox:  +   sandbox
>> +lib/libavb/avb_cmdline.c:371:48: error: a function declaration without =
a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
>> +  371 | AvbCmdlineSubstList* avb_new_cmdline_subst_list() {
>> +      |                                                ^
>> +      |                                                 void
>> +1 error generated.
>> +make[3]: *** [scripts/Makefile.build:272: lib/libavb/avb_cmdline.o] Err=
or 1
>> +make[2]: *** [scripts/Makefile.build:497: lib/libavb] Error 2
>> +make[1]: *** [Makefile:2210: lib] Error 2
>> +make: *** [Makefile:189: __sub-make] Error 2
>>     0    0    1 /1              sandbox
>>
>> Could you please send me a fix for this?
>> If not, I'll have to drop the patches from my tree in a couple of days.
> I've sent v2. Thanks for reporting the issue.

Thank you for the quick update and fix. I really appreciate it.
I've dropped v1 from u-boot-dfu and applied v2 instead.

>
>>
>> Thanks
>> Mattijs
>
>
>
> --=20
> Best regards - Atentamente - Meilleures salutations
>
> Igor Opaniuk
>
> mailto: igor.opaniuk@gmail.com
> skype: igor.opanyuk
> https://www.linkedin.com/in/iopaniuk
