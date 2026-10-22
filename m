Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05928606A31B
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=khugYCR8;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=OrrAxm/z
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71042812CE;
	Thu, 22 Oct 2026 12:37:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d0UtabcQv2Jy; Thu, 22 Oct 2026 12:37:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9984281276
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792672626;
	b=m395g3sYPvgQzgJR6ramQY5zA34puPLmYIm6dqHyLEc5ZBCv0Dq8pGqwusweOpbuSJoi
	 +oHyMKg8+zvx082Qj5uJ47TuJOTGidNnR2GuQWPRgqdpyzypwNoiZMCYrIETkGP1DBowa
	 01CpJm0nIZkGHss/v+ifPh26cuGubndpnXKMJVtAF2MGguzU2KQ9GR2gBz59cyhO4Wb8r
	 KUK0HopUKEbuj1zdwuG6ornoCH9r3LZvDObypeXKJSQDC5GQUXzIWXZQn4EpfkytBWSWH
	 G30Yi1ciNNyULWsjESUnLMU9ivbBkKmyfuCyX4CJVEqtmnO0nzAbvI+e6rGPczzaDcw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792672626;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=l7AJpHdps7u0VCLDhcgnkfUmuhSTghIiOIEZ4hTdFr8=;
	b=UN89SrsY7ep4poiN37PMoqY2UZrshTy8kZ2XdnQk/IaGLIusqT35YKfsxTGMayEvqh9x
	 ZxYefGbFJEyTeU3JiS3K+dU7x1VKEzkAe+pY4YnLtpNH5XV/lafKSkC3eZDHrJOVFbEO1
	 KwGF9KmMAy+DIFMO/1YKDfE8EsRYevFwvKkZ++NoW/67gFXlkt54MgFeZeQLAggXQtLnz
	 Ipe/p5/nrEALDeTRiuJiVB3HIGi8F/J/NYJI2WB55ax2hWKCuJFIwHM4BS7IYwnosnfLe
	 AHpOYlsSZr5liAIEy0As5HC7Hlm62XmVHn78dLAF7Qgf1Upv30DnnWl2nKc+d3JR26Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792672626;
	bh=l7AJpHdps7u0VCLDhcgnkfUmuhSTghIiOIEZ4hTdFr8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=khugYCR8dPorw5dGB+HsqO+f4y6kfYKy+XKikYFw1A1GscYKscFxZotY/277rtr7i
	 8ZC8swpGBTEAZSOF7VFv0nm8bL5s62/8U+TfEZVLYwm16NFqw810xzA8XcF7R8P7Fv
	 nR9+OmA7I1v8KgAP66tV8vGasm64Ej+ossKCpP9sB2+8+SN9RZJZvLL8MIa/763+P3
	 YXmf54LWqVLw7t4SLj2pa26lYgCJnFdsP83mGCjatYZvSHt7wqrN83cTw2A4pKBSHx
	 ks0EBCBqIauJheRwOwICTPbP0tgnU9Sx7lpDGmlCeJs4RhKuvWKqKExQOvVUdnhgej
	 HnBwJHrWm7qVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9984281276;
	Thu, 22 Oct 2026 12:37:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B2C2B2A8
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:37:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B05BE608A9
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:37:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uArYRFuoeAmb for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 12:37:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B7BCE607E7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792672625;
 b=jIATHAKRhnpsOOO3oKu29K7AXx/oPOnezYg8lui3Rw/V/67vRHmTCVMH1gM5rv7oNncg
 sfKMy6ZDe+vMo1tdPD1Z9iH+uAt8q8BhzYrSfKsXK7ju64gqN76qPg6fVOhlIwGen29hR
 DtoSBBtM/88BOn2WDXadnU5uCk7RNJX2Nlrvc3nfAHMfqbRGBUjg4u/reOB5f3MuIY8Tg
 QVwcZyTvOYw+Sb4m6OEpCWSKDJPr12wOSOdkpFnGXpEMEz67wUzpel+d1F145xfUWJVze
 4GegeqDshbOc+i4bHmzO1n5QlzTGEbOnciWuTMPPctC7U9vbKC037A2X21vJwf9eucw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792672625;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=l7AJpHdps7u0VCLDhcgnkfUmuhSTghIiOIEZ4hTdFr8=;
 b=hyYdQ7+T+pIrX93XG3C7a/nZ+jbnY5vYaKhuP/BIzfwKUU4sM+JKSR5TdaKp1QlsJJS+
 TMIbROFClCeX6kTdaoKh6BgF7Ii0ePWdqUWL3eZql3ItJqdWqjMHPOeL9YCU7e027H1xf
 vawz6FnwEOtHyapwSXRiY6kgdJy/bJsVjolU1mpjWRgL25PXypoWyOys6ZObDx8iSmDiF
 iqaMO42CSj+KysPnM+SIAjREcaQN2JmTfOIvhRE/4Juk6JM0QnSsb+DpIpu/Kz4i2jS1J
 Hxt4mboI2F9h3iQFpF6/8+ktMdvtchsSFDzJddtcWu46Aa6eL3AaM7IjDaBZiE1OHnQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b="OrrAxm/z"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=OrrAxm/z
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B7BCE607E7
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:37:04 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c37b612635bso253548366b.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 05:37:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792672622; cv=none;
 d=google.com; s=arc-20260327;
 b=sfP9HAYlc3N+ICHGmo9bBck/Zf9oH5bfin2Bq+iXg1H/AgnTjxoOPSedB+wpQ2MNQu
 IlmdqnAhyNldADQVnPPiX6kANQITg0auhl02M7o2Sdvm/r9WiEx0k6uDTnp6QZtwbtBR
 Rs6mmP6E9pmrLIC8exzPqTVDlOVCjKKsWTai/7J3Ig55PX/HzoINy+B6iyzl9QtDwT1Y
 VDaGFbncXmn+13VsRlQPUjflQUSQDzdGiG1pC8AV51LQseqRYp1S1NE0PpsUyx4+WvRg
 1I7xXF/uToNqMgxV/BrrsRtphwvB6rhjHgzNhuIG6T8iCEFm1sIwpu1vMPz2oX443dkB
 /Wyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=l7AJpHdps7u0VCLDhcgnkfUmuhSTghIiOIEZ4hTdFr8=;
 fh=Y0v1/WwJw6kxannqFo+mURjzi9HsTY9Fquub2Y4LgJw=;
 b=VPbeoUUi17EbNglS1Ye2RXSCQ4oHT7oQreGtJaw8JjIdjAp6DD7URqihHCV66Hprlf
 bq8928ONV2eWlAznO3NYYnO+Tyuw+DqCv5BjziFyirtOS1UEHj8yrRIkjpBeVQm73OkO
 622QK9oBXMraVnngzgntpnGxUylzCtDhuVOL8zQULrAW/CyQpuvcqVqgLHqr20hv3BEu
 VprjL6k4q5HEleHBMCZfpEJeSbOKBAt1vPYL1j8hxSHki8DGmTIvnWCunTq3Hq54+Fdp
 vvai1/c3Y7UEL3ndohoDzxKCbjeOExWKl5EzFHhaLdHSogLGot5cLM+FvwjswkQp6qfr
 84Fw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792672622; x=1793277422;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l7AJpHdps7u0VCLDhcgnkfUmuhSTghIiOIEZ4hTdFr8=;
 b=OrrAxm/zP/4EzkXgdhvHrVYwPTUJknJKH1wYzlzR32OoDFlyYlahkMtKtVXMkH7W3+
 QfBQCvCxJAV64du0r0Gr5APLRvR/r2HLmBwZaZhlaPk2wUM9SVMOUDo5hvAnVutocDx7
 w7fQK5IddmXrBecYCGMF4WOnk/TzvPmQCRHJvxOz3U4hPBLwY01N30PBOCv5EYRt7v2L
 VIWYCIE+jW1pY1lx2qGAZWvGl8jsBl6yLIZaZtc8Phtmg/Ic/x7ZNadW4vvUvk2Qg7ZV
 cTgFaYMerqqndrTUxHpamURhvVC8EqqYqyR2U7qFRED9wdHjI5+oM2BuBtvnXNHKvWwB
 /M7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792672622; x=1793277422;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l7AJpHdps7u0VCLDhcgnkfUmuhSTghIiOIEZ4hTdFr8=;
 b=BUhZKVrZc5eslyXevHk+iPhVIk1MC6iux0p+qtV++s340LGlmevGTDLEFtwSMH3j4Z
 d2OeCTkoezkp/tL61zm9UvOtPXMHRTvOXkl+5Iin01sgCJTrfefEFO2CcuKnzagUooi4
 Luk208CjoPfM4zw5WB7MW896BMoZcl+SX9MltxkcCtTEhnyA3p1qJOi0dIrQ1S14FFXu
 6HALI/GSYZ1lvKEtgHv3z/wO5ZZmUbnP9xaVoiWGlaCpvtvhoGi5K/gWcTfQP89UjpnV
 htU9Phy0v4TJ+CmJ9IGiGbrjSTY1X9/CsaKJRmBF0lp4x7WhUfjAo0JAutvDS12GiNp0
 KN3Q==
X-Gm-Message-State: AFq9FYIRhq37tOkt/TdfOt4dq+9wABmZOtb6UZi9bDwrqIQsWR5G5BT2
 2OSPE76fbaJatO4eJNFRLOwADXacGh5Ell0J0OYKatvAKtXZa6W8nRrBEMkP8mBciCyAa4/z5Jr
 KKT3BgL1jCve1uxK3oCdxKnNa7eVFea/SsuDlkuJqpisloRG97pGO
X-Gm-Gg: AYBFou31tllTLTxFEZhDYaP4fB1Z+LvXM0X63OAGmP4yJC/u5+a/IT3C+3CSx0zsyk0
 tDef2Se+Q2QkUhZiTSQ8GyunMMlmUPsbuNdVyv90z/6tkga3NmYG8avc9mVIdQ2D/SuTfnIyGC+
 D1XFFiARLczafBzVBLvtyAylF0bsC+qO7njSSi0TAaYN9MQFCsbaYukGo7ebJ/bTsO+1bIwfZX1
 9wNIOyGNQAVcT9jyrlL4JS6SjI7Z4nKxFE2g6GpeTatoUHSWznzgSQCJnHGwd8Y59b4QNta6VN7
 EIwpdDYAh4tycvgLIJ9HfpQhAQwVDTbZO03V/hBjEXUHpw+2MKbnMs+MRxoq9jjtFJfJb90mEq3
 6hVER1el8Lpw4/PNn86yshmHq6/JcRhY1MI3duJUAKOj2nyeAwiIDN9vgbNK79orBNo1npgE=
X-Received: by 2002:a17:907:96a1:b0:c42:5363:38dc with SMTP id
 a640c23a62f3a-c4679753a54mr523251166b.25.1792672622298; Thu, 22 Oct 2026
 05:37:02 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261002-unaligned-decomp-v2-0-675466ced78a@flipper.net>
 <20261002-unaligned-decomp-v2-2-675466ced78a@flipper.net>
 <efd080ea-60fd-4c15-858d-d63da9016be3@0leil.net>
In-Reply-To: <efd080ea-60fd-4c15-858d-d63da9016be3@0leil.net>
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 22 Oct 2026 16:36:54 +0400
X-Gm-Features: AclHuK_jCmeVwg4kR5UgnxXK7QrSTmjToq1s0WqxB0cckvBKSoUPmMw7fQ99QNE
Message-ID: <CAKTNdwFOtmJ36knSzGgGRpcpdvDcenK8ki9Eda24W7QhY+=y0g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rockchip: Declare unaligned access safe in the
 ARM64 SPL
To: Quentin Schulz <u-boot@0leil.net>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, Michael Srba <Michael.Srba@seznam.cz>,
 Cole Munz <Munzzyy1@proton.me>, Kever Yang <kever.yang@rock-chips.com>
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

Hi Quentin,

On Fri, Oct 16, 2026 at 1:18=E2=80=AFPM Quentin Schulz <u-boot@0leil.net> w=
rote:
>
> Hi Alexey,
>
> On 10/2/26 12:04 PM, Alexey Charkov wrote:
> > spl_board_init() enables the MMU from ARM64 SPL, and runs before
> > boot_from_devices() loads anything, so the decompressors can use
> > unaligned loads.
> >
> > Select it under the same condition that code tests before enabling
> > caches, so the two cannot drift apart. SPL only: U-Boot proper is left
> > as it is.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >   arch/arm/mach-rockchip/Kconfig | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kc=
onfig
> > index 1a2e7847c9e7..cc108e9679d3 100644
> > --- a/arch/arm/mach-rockchip/Kconfig
> > +++ b/arch/arm/mach-rockchip/Kconfig
> > @@ -631,11 +631,16 @@ config ROCKCHIP_COMMON_BOARD
> >   config SPL_ROCKCHIP_COMMON_BOARD
> >       bool "Rockchip SPL common board file"
> >       depends on SPL
> > +     select SPL_ASSUME_UNALIGNED_ACCESS_OK if ARM64 && !SPL_SYS_DCACHE=
_OFF
> >       help
> >         Rockchip SoCs have similar boot process, SPL is mainly in charg=
e of
> >         load and boot Trust ATF/U-Boot firmware, and DRAM init if there=
 is
> >         no TPL for the board.
> >
> > +       On ARM64 it enables the MMU from spl_board_init(), which runs b=
efore
>
> No? Only RK3399, anbernic-rgxx3-rk3566, jaguar-rk3588, RK3066,
> ringneck-px30 have CONFIG_SPL_BOARD_INIT() enabled AND it does not seem
> to be doing anything related to the MMU. I think you meant
> board_init_f() from SPL? But then the arch_reserve_mmu+enable_caches is
> only called when TPL is disabled (note that it is NOT "not in the TPL
> phase" check, it's whether U-Boot will have a TPL built at all), or
> SPL_RAM is enabled, which doesn't match the dependencies listed above
> too. Please add a comment next to the ifdef condition, the calls to
> arch_reserve_mmu+enable_caches and as a Kconfig comment next to the
> select that they need to be kept in sync.

Right, thanks. I think I'll create a new hidden Kconfig symbol which
both this function and the unaligned-access logic can test,
guaranteeing they never diverge. This will also save the code comment.

FWIW, all in-tree ARM64 boards either have TPL disabled, or SPL_RAM
enabled, from what qconfig.py is telling me. A stronger defensive
guard is the right thing to have in any case, though.

Best regards,
Alexey
