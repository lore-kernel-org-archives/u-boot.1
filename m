Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E67F606A6B5
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Rhb2Gd0s;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HsfKho4n
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D39F78174F;
	Fri, 20 Nov 2026 21:22:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IJlVIT_uGTAa; Fri, 20 Nov 2026 21:22:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 35F30816F7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795209767;
	b=l46gWptRyWQd+B2JizIpD1t797IabaXUpkIy6NfsI4SlXdHKJSb8PWtj3UtjEAPzO1K4
	 ps/NrxAGrohSMCg7smE9RMjmi+QAuz30Muqn9DuvHhg6ukHEFTjFoD44KgPTqABZ+kyAN
	 DGWTH++H/5O3YtdF6iml4yPlr9NAFaEbGdTAER/YAVFef9Y0luEgogc0vWi/7gjz+kjIW
	 UQk4nd7dGnDbMDBOunWi39wKsM8VLKnmBbk21XDLGc6Eq91jkg3ECzFI/Un5O6n8PVpt+
	 gcNVBfVG2MpQ/lv47FW9XOiRR7jzJJGzdNjZ2RdxJTEIIjruwj589795wAQSC6wx35Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795209767;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SmsDMPl1Alh7DBTYZb6sCDh0Y6CYE4XYVb/Aa4eH5QQ=;
	b=THtYvHQfq6tvddYp4x6ZaO+UmQ0SnRD+wiCSBo+WWCSJnNNkSB4kz3+yPtv4KftRsGrJ
	 ExUNws3JChma832NAYKLeagN86Btcep2cacp/2FtZBCi2YDS7PMztEu5Ydq2YfX34esPY
	 0i5pEcgwLZWqAmSkrqMqBPNQpz46ibHlgfc8iiqKGXuOdKakqNwvjOVPSRCfqmrscjIHL
	 d/Lc+2e8Jw3U4Nq2bJR5IF7b32jMhWwWhgaq86E9Q2FQDTn5MlEVeA+8gM2G+QZUk/mIl
	 WK95zmidjttI0Uq3GBGvtKdzog+CvxSgoZmIbcQA723VJU0FK9eHL2tmhgPfAFDympw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795209767;
	bh=SmsDMPl1Alh7DBTYZb6sCDh0Y6CYE4XYVb/Aa4eH5QQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rhb2Gd0sNbnaxpPjQ6hwXFbJPJIZwtJHdglOpu5bir48IZXWb+8Csl/cbhAzGx0Ro
	 m1LzFrnCR2YjMx/RFk7U8zzEo1TLdUQjEPg3nBo0eRIZ/YjvwEe+FAbMgfFmgIVj4s
	 k00HWbJaGHgDVxBH6W6+JpLL2ST5Fw+OhJtyLMju4KM1N/rgx12V2Yqr8yEAkxzm6v
	 hKte7yp3lbHd0jab+/7GuG5EjW9KOJFGNNu2FTkbkJbu14bNBUbJmilqE3rc/Y8yrA
	 MRQgW/nLpDe0k3opspjApHkUOFu5bFVXfCWuXPr+crbgE7jpxF66QG5PHvqZCgC2oJ
	 UsdD1thNv3rlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35F30816F7;
	Fri, 20 Nov 2026 21:22:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A2483465
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:22:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8887640AE3
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:22:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jhoRtAUBr8tr for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 21:22:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E869B40208
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=HsfKho4n
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E869B40208
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:22:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 92AFF612A7
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404D01F000D1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795209762;
 bh=SmsDMPl1Alh7DBTYZb6sCDh0Y6CYE4XYVb/Aa4eH5QQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=HsfKho4nvR7sli/DglSPkt030Bi8xAXjz7DUa19W0M4LkQtQltDsFHNN6YoFCrWdN
 9vYI4RcQHeWgAbmCd+kAYpSMU/PMZ0xvR7lHvq7VoGwIINjZ9DgQ68fRnj0gzGVAmy
 2KbZWLhR7g/EbWLsdrW7YJnDdVoXPFer8saKcuYlqKqyx73XF8xD+0wKVQAbm5zboa
 0uK+g36aV01RmnRKjJFHSzeTOvXcaHNfRABdRKEy8XrQLPxoWoAL51SwUk8F6Dg9lk
 A0mgAb2BFm6Mt7yH3FtBa4Jv9UJz1LlvLnhQjD6WkcshkskmEgMLvrRwma1WNgPfko
 04UF5aKljeZ4g==
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5c148d4dbfbso1213484e87.3
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:22:42 -0800 (PST)
X-Gm-Message-State: APuU4Z/hUIcBRb9Z6Tkfb5FyPpxeeJ1XR7c6asKHHVmfI5Od2OpUqcgx
 cPz1ju4iTfaBcCvlGv7I+ImqO3q5xFDYhmNsFjjIMH/HaKmKIJmI/eE+npkCEuOSHGBaEskg4y3
 w/iSHT83KKg8LjuNI6VPVjQabsF+02e4=
X-Received: by 2002:a05:6512:850e:10b0:5c1:56f5:fabc with SMTP id
 2adb3069b0e04-5c1bc7d5cd9mr1049803e87.24.1795209761018; Fri, 20 Nov 2026
 13:22:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116174501.3488413-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20261116174501.3488413-1-marek.vasut+renesas@mailbox.org>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 20 Nov 2026 22:22:28 +0100
X-Gmail-Original-Message-ID: <CAD++jLnZOiC0Kd3r+VGOUfAH7OFX6Fq8DLjUBk+cmh5R1WuBpw@mail.gmail.com>
X-Gm-Features: Aa3M54oUrVh2_R2J31rO5DuNLd4IWGV5_fFmFI3i-I-Zi2_G-52aTVsACZeTPxQ
Message-ID: <CAD++jLnZOiC0Kd3r+VGOUfAH7OFX6Fq8DLjUBk+cmh5R1WuBpw@mail.gmail.com>
Subject: Re: [PATCH] video: Constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Tom Rini <trini@konsulko.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 6:45=E2=80=AFPM Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:

> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
