Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B525CA6018
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 01:10:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16F736083D;
	Fri,  9 Oct 2026 01:10:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UHhZqGdQqxrI; Fri,  9 Oct 2026 01:10:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BD3D86082C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791508212;
	b=sYt8jWFblYzMaaw4yuwqwxGMxR/qB7uXzf/ec9/Kc1HTrNImPqa4TgM6Q6RaXVjqBPW2
	 vcHzbFdkdURcYP9Yq2h65cJ8IN8HkhMF2tMsY90B11gQl1J1mrCoYiWOhyFIlMgOWXlyF
	 36c9cpCNZBw/JWscSZ0S2PlWLi9AYgSEYCDjsrfCgC2L1kl9mmSF96PrYD8bRsAh1tBrG
	 tN1JENBp3t8pqoiiaZLzXTB5RF/izHoczXA4s7ofwR/gjUXLeShQQtlJt1CivgClo4N5j
	 suI8ISXg/CzMJERJ5SGZQsLAW0tNwshoCmvEN4tLyzZA7xkqH8shoxBYXp+27ptJe5Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791508212;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=91NmnubAOEaO2s5Dh+WYFOsMPQpVyZAadkQkTzy+aYE=;
	b=kOWonUqE6X40GsYz0nzpgCI4d4cnN/AVZtbxollenSn4RFfvqgEg4N/Jk3fwLibr4rub
	 FO43aPBCXey+02bNTAXIk53JJuboys/c0q7S6MWr0L1F+8eaBDcdZFb/LdXo23zbYzuIj
	 0u0JA4E2YSzcY5UlDU3Y0edsEO+qnpB/8QGZYNRkl/vvHq6RxuLGosOr/HBZlk8KrbWT3
	 CdA1cM6Q9KZY8AKuO/CvmJry5mQAUrPRiPt1EHNYj4Fy9C3d37KDPYB6gz8+tKTH7PnWV
	 SHEYHQfEVSVFnTRCksAPff95yKbaejoGiLryc8oDCousCt+h2avTIci+jskXddDM7ug==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791508212;
	bh=91NmnubAOEaO2s5Dh+WYFOsMPQpVyZAadkQkTzy+aYE=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jh50efdAFNn9T9vliHsTdn6zXl/S0XLCTi5mlxUy9lJhsSf/np9OfzlR9YKQi2wpm
	 jrhBMdZTpS0iMlTaEBrR4ySf90ZKEm/s/4LLCcDb1KeYBmIbU+27v2p7uqct92bXaO
	 vM21RBhLJqG0X56FgFzSwtDmRzltW/6lY30VgbXqmNA+lgsGZP2lvhc7JqxZ4EQ8rA
	 rly7TpREgnupyXGimwOg55kutb+LfPcJ5Ii4MjWoJdQHKS/MD3M6BKkvL/EKZJTgL4
	 Nv/DLmZDBenOtYF1MKlUeexB7xywj6KchlFt1JJ2oQxqurrgi/8kko+eFOVyMuf1H9
	 OLIvPny8Qi+ZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD3D86082C;
	Fri,  9 Oct 2026 01:10:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9676D1C6
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 01:04:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93B9C40912
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 01:04:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cpNiEZgSEKpK for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 01:04:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2722140911
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=85.9.206.169
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791507857;
 b=S9Xflc805ur1cObqtLopC1aJqhkmVEwYkoEGgXkmts7F4z205mgEd97qcCIhl6vSMrYd
 aSMwM69aTvLcN4E7xKWFYpMKs77X+SiGSd6ZSnbghilp96PBVFBqQiV0bxl7mp0weanGI
 twpYbO0X1irdNs7rITZmFFVRv8UEBcozW7HHCAh9MIL0RLHdHeuQJ8TfEC9oBuWr3NOIB
 9NLgHNFTPnrcEwpGBCd0StOZrvpZZugwjM8twyTkKrrRAbT88qiMOEBZ/eA9ZscgU+7Pz
 bBarXewODhEUrT7WVbj+qvolIceVAhrMIU/iGl2nyXZ/O1++9El1mGiYTIt1e/l/c/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791507857;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=91NmnubAOEaO2s5Dh+WYFOsMPQpVyZAadkQkTzy+aYE=;
 b=im3aZCtsLXbzm9FroJKA05YAmnPaG/XdZPDemIXlxSSq0WFOryhkM054rdJqL9Idkl8N
 hZyM0R0OvRYTWP+KovUfUG4QHu/2VIkNXHeA/dQGsJVcHJKabs4ej1c5QzIF7sRNl69Mp
 Fnt/EGYR8qYiTvQ1b0pkTokjT0bRND4F74SrXx5/4fxNZzn7lHK3SenHyWldqvVko6UWm
 43NNJhflSjrKOWqOCoak1JuBmDNzoVvmehP7jbK81IY/DOkbnai1Tiqskp2xzYrIgAs19
 pGqwUpRy4gL0ZGofnpLgOP2+JmWGgN2d/9Vth0petGGMp/2L30816/crKuTE0dFx9Uw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=proton.me;
 dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail2 header.b=EFtVqFOl; 
 arc=none smtp.remote-ip=85.9.206.169
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.9.206.169;
 helo=mail-05.mail-europe.com; envelope-from=hystericaldragons@proton.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail2 header.b=EFtVqFOl
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2722140911
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 01:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail2; t=1791507844; x=1791767044;
 bh=91NmnubAOEaO2s5Dh+WYFOsMPQpVyZAadkQkTzy+aYE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=EFtVqFOlmtVr7Kk5pY4HbxBdjhecHKeNk+kYaShsTLjOtAyzNkRi4Jw16hkP9GVF9
 7oJZcdmiS5Van86Wo/F6+mTdSK33Z7tMlkCagLlampPoy6kq6x7Ug11gVeHb2LiohG
 5K5HhDDlJzsn2BvEryxhYu1zaxTKaCc5pOKoRBl32AevV5rBe/RqD6mQk5Wzr2VSey
 3mkOk3rRgiyyq4QRRy41TAWdkEzA0AyNFdu0SWmffvEphjJx9wpScyCP1ot9Z65/X2
 9ZStAmNgnGYO8Xi9CBxde3h+QMVSimZFMCg+mM34narYFH5uIoXWEzE9WDuEkhyQI8
 PGeMwPk+4aqyA==
Date: Fri, 09 Oct 2026 01:03:59 +0000
To: Quentin Schulz <u-boot@0leil.net>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
From: =?utf-8?B?5a6J5a65?= <HystericalDragons@proton.me>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [RFC] rockchip: rk3528: NanoPi R28S support before dts/upstream
 sync
Message-ID: <EIKvr7SgDhRqJeb_aUvosExauf5kc0Lkze0FJ3Egv5ZamDocTA8YjJGRCu1WLO-t105liF11Cf-Mmdbw_QYwfYL4D84usfWh6Ga0Ybs0_ls=@proton.me>
In-Reply-To: <866df3e5-1e1f-4453-a964-9a1e48e56a87@0leil.net>
References: <OjXy0xMi4UhaNlSDbglwvkf_FXX3Kg2TzBsaucWmd7YnY4tVJXGpdp-sUp-mApm8Zh9935uuKq1jhneCiItNCisIRiN66zEG8zl1jiGBFMI=@proton.me>
 <be3cd318-cba7-4c04-914b-e859c222ddaf@0leil.net>
 <wZ90PLwVcDDHWjgk7robBmaw1YmdSxF2l4qP0CirT50SG0pcnFMha3Ahz00Hzo_ZyZd5DGXiVDruI_ic8UhKYUIlRcDyCCy8LrH0ZtulEnY=@proton.me>
 <bbca02c0-ed81-4a78-8861-43b69eefbcb1@0leil.net>
 <21B8mQuUfM4XSy1qMxiIYNYmj7yL-bnDWso8_9HxHc_ZDcpqyMHgpIKQEYqgGqYg7OHdfvrdMXH6pWI3I3UU4zP71BbqKZWyT3-nayVAhDA=@proton.me>
 <866df3e5-1e1f-4453-a964-9a1e48e56a87@0leil.net>
Feedback-ID: 91982645:user:proton
X-Pm-Message-ID: cbf09b420cfdbe2e77c28c937eac1476c0626293
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 09 Oct 2026 01:10:12 +0000
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

Hi Quentin Schulz,

On Friday, October 9th, 2026 at 4:57 AM, Quentin Schulz <u-boot@0leil.net> =
wrote:

> Hi Rong An,
>=20
> On 10/8/26 4:40 PM, =E5=AE=89=E5=AE=B9 wrote:
> > Hello Quentin Schulz,
> >
> > On Friday, October 2nd, 2026 at 5:37 PM, Quentin Schulz <u-boot@0leil.n=
et> wrote:
> >
> >> https://lore.kernel.org/u-boot/20260911-b4-lib-qrcode-v2-0-c5291fb7c64=
6@protonmail.com/
> >> has the "via B4 Relay" I would expect when using the relay and there's
> >> no To/Cc matching the rule above. Can you give it a try? Maybe that ju=
st
> >> works?
> >
> > That's seems a good idea. I will try it at first.
> >
> >> See https://git-send-email.io/ (hit next once), they list tools that
> >> supposedly work with free accounts too, that could be an option before
> >> going the paid route.
> >
> > Thank you for your clarification. But these choices are a little unethi=
cal. I've been wrestling with this point for a long time. If a patch is sen=
t via a Wi-Fi hacked by the sender, could it be accepted? Then re-consider =
this problem with email -- can the community accept a patch while the sende=
r violating the ToS of the email service? I can swallow the reproach of con=
science, but can community accept? I don't know. But refer to the contribut=
ion history, this behavior seems acceptable, so I have nothing to hesitate =
about.
> >
>=20
> I don't think we care if you break the ToS or if you are sending patches
> from a WiFi network that you hacked into. I don't know whether those
> tools are against the ToS of ProtonMail but it was not my intention to
> encourage you to break their ToS.
>=20
> > By the way, sorry for my latency of reply. I am a little busy these day=
s. And I have to think the problem above so that I can't start writitng thi=
s email. Luckily, the r28s' commits is not in the devicetree-rebasing now, =
so this delay not cause excessive damage. Once the commits in the devicetre=
e-rebasing, I will send the patch as soon as possible.
> >
>=20
> There's no expectation on how fast you should answer mails so really no
> worries. Not having a device supported upstream is also not causing
> damage, so really, do not worry, take the time you need or want to take.
>=20
> Cheers,
> Quentin
>=20

I forgot to add receiver and CC. No further comments from my side, just bri=
nging this back on list.

Careless,
Rong An
