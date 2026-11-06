Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A260606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Czx+UwQw;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bI8/7y/x
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99E3C607C8;
	Fri,  6 Nov 2026 09:55:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UD_JTkxJEah5; Fri,  6 Nov 2026 09:55:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 89C926079B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793958941;
	b=m90mO6l55aCauWDiYvckDsLGftICmCYcJK2tRR2bSAN57XAJjH5yYE2SHUs5/YbBzaWp
	 L2GVO00lEoQrpAk6FKOglmAlDJ3r8u5JIt/yhgjW/6jNtamj1e6mvQjeI0inOQIMUDcFF
	 GgQLEFCF1Be2QnA7Sx/EVAsH7+I+atZ4x8gfrmHH6Hi0yJsw2U1yAq+mx0zZlZ2qre1yo
	 YwxfuG10tNKKC6Jok4Bxkh6Q+tOzb0Bh5ea98SSl1dBVdh0asqMD5lZF+cslZADd2Uj8d
	 xw5dBgX9/SxSduebQ2HTzlXo9tulSL+cFcTfUIPS+2aJbFy5ybq+W+/lia/KCbWd7LQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793958941;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MQ4i+VUWay+scbHqa2nafvqdVdqNb/IfwIQ4grY47Us=;
	b=h1xxiojUPRDe7di3X7L5YxRc7hnPqT/p4wYTwa1silPF9z/cUg65fpjwxdfetb1Dovo0
	 CIKJ15b9xOQQ5sw6jtdiWhD8RDDf2eVXcQB4DRpRiUb2b89FEUT8lHhEpYOz4XMKwoW3f
	 7tRLAXN9mGMAE4OWkc5D9cqgB7kzHSv6MHTw8VTSVy6O1ifa/jGObZeagwoNyh6vkKIb1
	 gtqU7I20BEJkluUh3Fro7WIhZmgGT3FyHG/5FHm4CDqausIZxba27/eUo8eF37/TK58Wd
	 5kqSkOsjEOKMcF/yUcHo52cA2PY2OnrhoBeMhuYxskGxrN+HiDHjKVJSIc1a39M0NoQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="bI8/7y/x";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793958941;
	bh=MQ4i+VUWay+scbHqa2nafvqdVdqNb/IfwIQ4grY47Us=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Czx+UwQwHCT62M100RQ0rxDUqbowrIczZo+brkwlgpwvkA3i/CmAqL9+INGeTDOzf
	 NQzSkU8UUbTO+I/MMpWkALtg3yQQvQVQIygfnAem6660c3uYJZmcq/L2smFXTzYIcL
	 r8MFy+qxs/nxH1ys8hvwlRgPvfM9WZnX60EgX1+yqddYcllW+8PGTAUqvAYvzIKxb2
	 b9FOeXKlp4UysUMp4O4gjhJzjopX+SkAIj/Lb5nMSptgYYAZijpnfNpsiKeuU6IHx4
	 KtcUkTloDusctmafdrPYxLoyczYtYdMK1ZY6cyCw/PwX1yyc3c0+eMJS7titIHFG3s
	 CVYCs1KTkZbYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 89C926079B;
	Fri,  6 Nov 2026 09:55:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 81C9534D
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:55:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 734A36079B
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:55:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5CD85oSW8H4e for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:55:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2F753606A5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1136"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=bI8/7y/x
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2F753606A5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:55:38 +0000 (UTC)
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8b31448caccso3125097b3.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 01:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793958937; x=1794563737;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MQ4i+VUWay+scbHqa2nafvqdVdqNb/IfwIQ4grY47Us=;
 b=bI8/7y/xbjMTpD8uVPVTWcF84vLF+vbrfzrlmC4fKrTSNtgDXqCl3MSLMFNk9rn9XR
 0rzoYlN1jrHojhTQgbAfXGCLzGtGAfYj0NINTEPnMSTRg9WGhCrKdwYXQDWkpNNyfdfv
 LKjv9zVgS2v9MsvCJTW5pcaa/VrzPXF38xc/of/MWXm8ONkSUssNPUQ0Es/nu7N4WPlg
 8zXCqNd7smRdDV2niWKUDfXMAwsfG47VkYs09HrHbnoMkYKZucNZhDRzMJdF9X5XB7xC
 /jNZws7j6QrvtlR0bXZlxmdOvuCohZSzp+5cn2nxLYn8Jl41roR8BhL5anNUp+JBxm1A
 fh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793958937; x=1794563737;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MQ4i+VUWay+scbHqa2nafvqdVdqNb/IfwIQ4grY47Us=;
 b=U2xDBHUKl9X0ebKjHvLlj7Q/GnBhyZwHD7U9lXSwOcBtQdnVOHv3j05fvOuFI5WgU1
 qve5TD4GkMGLNmqwh4siJWpK7MRiGxJ1K5sL+8FKK3T0s789Bo+6B4FbZ0D5WVK3qyHz
 g3xvH0gmaImbF9o1K/dYWQBDgfgvdKXsVBXGS+I6GEUmazKmEc1aI8jYsibfu8JqckJ8
 Wb0y/cgq2ji6QpZCLcTuwDFTrJgyRqWIEwI2Uo1gfxY0YJn5iSM/ds7ltZR62mKmCQ6u
 457bR9Wcf9tZEtyImTfKmurZxosoVM8d8KTgIDlEmDKUKsFxDALph3szzuYxAuXtf7p/
 +Xtw==
X-Gm-Message-State: APuU4Z8lKWTeHCMhAeQtCk+mcQVOiQ3mZ4ftb78/zZc+YCj1oR+gLsko
 EbOQkKp80k7finARqs73smaVPdg7EK4yXi5B7NHr+B3YUJcLz+AHrhyWLcHhCCeb2Vk6GxINbVy
 5OG/QR//D5N11TC8dBHaMuhf6QnsEswqyBFhlB9lO+umRiAhEo8bK23o=
X-Gm-Gg: AYBFou02jOqiGAO7fx3yFsrtthXPSSKLtNzvSWRlW1kLBOnLqrsvdS+jSkRki10w+tu
 qLNuw7Gx4jiJ03q9I9jaVUXVWCL/ibBs0SNrIwZsM5ZFpz7NbVHsn8scNq7l+FST6PP8JWsfGu7
 cnUQxVOV+TQeHrrBG5wSewsMMwj47DNsFmQoz98r2ze42VIW9mKMRWBlNByyd7Xl/bhwMwOAvMl
 543z8nsds9H6hE4qpWqiNGEyPQqG1ElhN3zoVisGSmDqVjfBWw1IGNHgsHo0Kb46C5Vgnd3UMDU
 vDvigP31OFhFsBVcs48+P4z7tviFh/3U2qkFWETVPs46gz27bURDu0HVnyd1BRChUizyNOG/5Dv
 5LwLfir5IPV7TfNegvdtFa0cMh0kG7/zlB6PQPUTv1Gr2WAoidFWqFtVvFJojWTZy5cmRFPz5Zs
 /ohHhKBtAff7kln5tfxwX27P376Jh/O1xjmPBYQCUyUXxf+FMAA1J+t1ep8rSA21AWBvO5jN+gq
 8UFTBSe5KwyyV7N+oqyZKP1ZTuaS0ZFaSB1+tEi0MOX8o+Hlsnmwqi8nxDIr8dU4JDgklmG+Nnv
 7bW3bNClEcFJzeylOLzLLXB5Cx26hxziTyVJpXvJXwQAsxj2dpZmi9F/gcSNEjTLymm1jvdH7FC
 BTk6OEVn66FQGEb/+VhNmsH0U8NVzz5z+AzuYF7utCHAbCc715vJaWysO2+YHL48aLKwaP2Ji1J
 5WQVPTwVdz0swoC9eZer1svd5CyZ2Zn9WTmrk=
X-Received: by 2002:a05:690c:30a:b0:8b3:1fab:fbe5 with SMTP id
 00721157ae682-8b341b3448fmr13439877b3.67.1793958937179; Fri, 06 Nov 2026
 01:55:37 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106072729.1714418-1-tkirchner@emlix.com>
 <20261106072729.1714418-6-tkirchner@emlix.com>
 <CAC_iWjLSSGbQ=s_r7YFD=ZXaPP9X9Wj-cuJrhxThma-DkeLGJA@mail.gmail.com>
 <65cf8b81-31b0-4a9a-830f-741fa6830c6b@emlix.com>
In-Reply-To: <65cf8b81-31b0-4a9a-830f-741fa6830c6b@emlix.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 6 Nov 2026 11:55:00 +0200
X-Gm-Features: AclHuK-k_abjjsn4afeGQzcYDbRSpPdven19rlCJ0fejNzWkpPk0F9NWz9R-09w
Message-ID: <CAC_iWjL=rU2Xbten1cX0sH+wCwYz3yqsUaB0m2K2Mi1NdyeMaQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] tpm: deactivate unsupported banks in tpm2_startup()
To: Tycho Kirchner <tkirchner@emlix.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 6 Nov 2026 at 11:51, Tycho Kirchner <tkirchner@emlix.com> wrote:
>
> Hi Ilias,
>
> Am 06.11.26 um 09:53 schrieb Ilias Apalodimas:
>
> > I don't mind keeping it, but if the previous boot stage supports more
> > algorithms than U-Boot, this is actively blocked in the TCG code,
> > IIRC.
>
> Right, with an event log tcg2_log_parse() rejects algorithms unknown
> to U-Boot, so the fallback is not reached there. It is meant for users
> which do not go through tcg2_log_prepare_buffer() at all, e.g. a custom
> measurement implementation on top of lib/tpm-v2.c (my case) or, more
> importantly "tpm2 pcr_extend", if an earlier stage already started the
> TPM.

Ah yes, fair point. I keep forgetting that boards might start the TPM
earlier properly.
Ok we need to keep this check indeed.

Cheers
/Ilias
>
> Thanks for the review and testing!
>
> Tycho
>
>
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >> TPM2_SU_STATE, used by tpm_resume(), is left alone.
> >>
> >> If the deactivation fails, e.g. because the TPM refuses the allocation
> >> or no supported bank would remain active, return an error. With
> >> CONFIG_TPM_PCR_ALLOCATE enabled, U-Boot is expected to manage the bank=
s,
> >> so fail early instead of at the first PCR extend.
> >>
> >> Signed-off-by: Tycho Kirchner <tkirchner@emlix.com>
> >> ---
> >>  lib/tpm-v2.c | 13 +++++++++++++
> >>  1 file changed, 13 insertions(+)
> >>
> >> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> >> index 18ec9eb960d..6370b97a7d4 100644
> >> --- a/lib/tpm-v2.c
> >> +++ b/lib/tpm-v2.c
> >> @@ -201,6 +201,19 @@ u32 tpm2_startup(struct udevice *dev, bool bon, e=
num tpm2_startup_types mode)
> >>         if ((ret && ret !=3D TPM2_RC_INITIALIZE) || !bon)
> >>                 return ret;
> >>
> >> +       /*
> >> +        * Only the boot stage which actually starts the TPM deactivat=
es active
> >> +        * banks with unsupported algorithms. On success, this resets =
the board.
> >> +        */
> >> +       if (IS_ENABLED(CONFIG_TPM_PCR_ALLOCATE) && !ret &&
> >> +           mode =3D=3D TPM2_SU_CLEAR) {
> >> +               ret =3D tpm2_activate_banks(dev, 0);
> >> +               if (ret) {
> >> +                       log_err("TPM: failed to deactivate unsupported=
 banks\n");
> >> +                       return ret;
> >> +               }
> >> +       }
> >> +
> >>         return tpm2_update_active_banks(dev);
> >>  }
> >>
> >> --
> >> 2.47.3
> >>
>
> --
> M.Sc. Tycho Kirchner
>
> emlix GmbH
> Headquarters: Berliner Str. 12, 37073 G=C3=B6ttingen, Germany
> Phone +49 (0)551 30664-0, e-mail info@emlix.com
> District Court of G=C3=B6ttingen, Registry Number HR B 3160
> Managing Directors: Heike Jordan, Dr. Uwe Kracke
> VAT ID No. DE 205 198 055
> Office Berlin: Panoramastr. 1, 10178 Berlin, Germany
> Office Bonn: Bachstr. 6, 53115 Bonn, Germany
> Office M=C3=BCnchen: Am Knie 16, 81241 M=C3=BCnchen, Germany
> http://www.emlix.com
>
> emlix - your embedded Linux partner
>
