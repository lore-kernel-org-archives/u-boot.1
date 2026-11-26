Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A42606A31E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FGbo7KbN;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPocbzRo
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A85080B88;
	Thu, 26 Nov 2026 12:57:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UCB0Ldp0i0ia; Thu, 26 Nov 2026 12:57:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8FCD08114B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795697837;
	b=aceefbKN6wlHtVTL+cGJkqzqKDY3NNueJkyZyhgkYN2GXkaVUNKLUHGaMHd6NvRwYk0s
	 HDGGcVSRkhqxbRhuWTycqeZ8lwLk4xxXndZopWHXyTDWUEax88C5UJQL85pESfMFKTFYh
	 J+ZgyyQ1FmduL0ssZkAEAzWNj2s4/oRHv22DvI2uApBgUbw7FfBelMFaPmjPGgIoDroaz
	 fv2IE4UsrBXrgVAp8FK68tGjFYAYqO7wP0Oiyjgap6p8KjjHR2mE3LAJd5JqoJNtun9x3
	 cp5BSpwTCC7ffBBravuW3Qh8DxkoNfadOeuHFZFcpy/s7iAUm1hmOQVqdJKejyJh6fA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795697837;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9JAI8D8EpOjOeVB6g2tGVskDtnFP104G2yThIKuRPBg=;
	b=SUg7y5QHqyhE7+sG1cE2iegfscghsyRUpllRmqfb4qZe8YZyzabQxytr8d/l+OwMkXMq
	 6TGIRCNuEYNxWSDGp+sRmurZLOSJHH2+egUdH2AJQ80wVaAMOMPpHMH+0X9mn1ZePAALN
	 w12tZdaPAr7LnuA3x8gc9BejK3Go1K7tDa3bemodGTmASuRiXNH/Ac99c7LQeEo5Nr+i5
	 39XYkKjpvUKhCkN1vFEAnFDsNB3CTnK5Y6+gwE1n4c30mhsrzQ9l73rgeIsgCP3rdRnUQ
	 CKOJT5vllxxIx8aGqibkvxgAgyPqia9lqJaaU5PJd/T3UWPHmBquhdpVfMz6D0qRgAA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPocbzRo;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795697837;
	bh=9JAI8D8EpOjOeVB6g2tGVskDtnFP104G2yThIKuRPBg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FGbo7KbNR4cy3Gc6BFxd5FBu1KUM6Jv6PWIBuvW8Euq9qFkh8A0wV/anP8yIWqBRo
	 /TgDxHas7NwdLd7RWHJdqX7IXaMy3iU7cmUVgPD06CwBcy7f1OW78Mtyf5NWozh37D
	 whJeR99ebtoppeCk4iajLKfNpSN7/RRluCeJhL3WV7rQrLaZifNyDD9eESvY21l/LD
	 m8Vn/BgMhhTmVthqenlMdSKsXRlgFvsg+8DIVc2y23o2Wg9VB+ZTeUA4sEC6/v871P
	 va6kNTFN7NVpz4Ya6TcLZ3TUJIABfsnOgPWlvsRzT77/36zEOITZa2VduWrXuOCwDN
	 3El3lrbHPenZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FCD08114B;
	Thu, 26 Nov 2026 12:57:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 63399325
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:57:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 550B280B88
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:57:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fd9uQ1Yz38j2 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 12:57:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 982038114B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=aPocbzRo
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 982038114B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:57:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 15F804118B;
 Thu, 26 Nov 2026 12:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0590E1F000D2;
 Thu, 26 Nov 2026 12:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795697833;
 bh=9JAI8D8EpOjOeVB6g2tGVskDtnFP104G2yThIKuRPBg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=aPocbzRokRYrugRp5XPZybuR71lRvLaeHIPXtBrqMutkaru02bi4fvOKYoUbNvjSX
 cyT4zNppWMwg03TB/83wjyB2Tb+CPObZJagVHE0fFG5/yttxfQ4KjxSMwVHmI35pUC
 4DLcPVVy5T2osH/3qu/mwQyJoDejGKUqOuG7w0KHudNMCzZjYsAEUOnDi+mhiYWG3C
 MqlVF9nLxK/e7+ij/pZEMwhtp6UWJYPzYYTXV1AzSY06AnLtVMR+O+4uf1KL0g3d/3
 FLPhukuPEMuaTZf2a8fVHa7yRWaVckqzj+v6OurLkJMyvH7hKLCNcC723AK+6kZKiy
 WI3FXS2xoB7VQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>, Jens
 Wiklander <jenswi@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 1/5] tee: sandbox: keep zero bytes in persistent values
In-Reply-To: <CAPzfCAYg20uUQdNADtndLCM3s0H2KyvD02=rS=RBkmPR3qCzBQ@mail.gmail.com>
References: <20261107-upstream-avb_tests_b4-v1-0-9177277458f9@oss.qualcomm.com>
 <20261107-upstream-avb_tests_b4-v1-1-9177277458f9@oss.qualcomm.com>
 <179501661321.306911.17120967959562497081.b4-review@b4>
 <CAPzfCAYg20uUQdNADtndLCM3s0H2KyvD02=rS=RBkmPR3qCzBQ@mail.gmail.com>
Date: Thu, 26 Nov 2026 13:57:10 +0100
Message-ID: <xhkdb5wxjzr6h.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 16:11, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>=
 wrote:

> Hi Mattijs,
>
> On Wed, Nov 18, 2026 at 4:43=E2=80=AFPM Mattijs Korpershoek
> <mkorpershoek@kernel.org> wrote:
>>
>> Hi Igor,
>>
>> Thank you for the patch.
>>
>> > The emulated AVB TA keeps persistent values in a table of strings, so a
>> > value is cut short at its first zero byte, unlike with the real TA.
>> > Binary values, such as the digest of a user-provisioned root key, then
>> > cannot be tested on sandbox. Store the values hex-encoded.
>> >
>> > Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
>> > ---
>> >  drivers/tee/sandbox.c | 17 ++++++++++++++---
>> >  1 file changed, 14 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/tee/sandbox.c b/drivers/tee/sandbox.c
>> > index 16e5d95616ce..92e74add3e3c 100644
>> > --- a/drivers/tee/sandbox.c
>> > +++ b/drivers/tee/sandbox.c
>> > @@ -4,6 +4,8 @@
>> >   */
>> >
>> >  #include <dm.h>
>> > +#include <hexdump.h>
>> > +#include <malloc.h>
>> >  #include <sandboxtee.h>
>> >  #include <tee.h>
>> >  #include <tee/optee_ta_avb.h>
>> > @@ -268,7 +270,8 @@ static u32 ta_avb_invoke_func(struct udevice *dev,=
 u32 func, uint num_params,
>> >               if (!ep)
>> >                       return TEE_ERROR_ITEM_NOT_FOUND;
>> >
>> > -             tmp_sz =3D strlen(ep->data) + 1;
>> > +             /* values are stored hex-encoded, see the write below */
>> > +             tmp_sz =3D strlen(ep->data) / 2;
>> >               if (value_sz < tmp_sz) {
>> >                       /*
>> >                        * For TA_AVB_CMD_READ_PERSIST_VALUE2, reject
>> > @@ -287,7 +290,7 @@ static u32 ta_avb_invoke_func(struct udevice *dev,=
 u32 func, uint num_params,
>> >                       tmp_sz =3D value_sz;
>>
>> tmp_sz gets overriden here again. Is that not a problem?
>
> No, that is the truncation the code already did before this patch.
> tmp_sz is first the length of the stored value in bytes.
>
> If the caller's buffer is shorter, TA_AVB_CMD_READ_PERSIST_VALUE2 returns
> TEE_ERROR_SHORT_BUFFER with the needed size, and the older
> TA_AVB_CMD_READ_PERSIST_VALUE cuts the value to the buffer size, which is
> that second assignment. hex2bin() then converts only tmp_sz bytes, so it
> can't write past the caller's buffer.
>
> The only change in this patch is that the length now comes from the
> hex-encoded string, so it is strlen() / 2.

Ok, thanks for the explanation. It makes sense to me now.

>
>>
>> --
>> Mattijs Korpershoek <mkorpershoek@kernel.org>
