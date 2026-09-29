Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1433CCA5FA7
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 18:18:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D363280F10;
	Tue, 29 Sep 2026 18:18:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gzEz9EFHY8Sq; Tue, 29 Sep 2026 18:18:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 23A2980ED4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790705907;
	b=lK7yQPm1yNoK4ra6V08MIudybXloPIBdIQDmoItKXZgF5R77hl89qm7A64GrU3I7aBtb
	 0sruCxwfDx6wvlzpamIts9GJJdPzvEuqY3jz0Q5UBFZ8Gh1TVtBVloz3E7Gi1oBQPeMmM
	 Q3UMW8fMC9zIQ0P3WXgi57GsCzjm0st2M4hu7vm8xUThGiP4Dg1wfCAFwCTliXwlQauB4
	 IAjqudeBraOtQVuA+t1fH6DZtr8SdOFeeoQHzQB7+U8CV991J4r/RocfdSK6CbmS8MEuX
	 Vm0uQFi7JawoxJW06Vlq2EGjhbMz371ehYELlMxzewO6tznqFxsl1HGupxW2/NXVgKw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790705907;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wZ2bGMe0KK9Ocy2boHuAgoU1jlVtI6PrZ+mcKJ5BHRM=;
	b=b7gVQh4TjpRbLLtO3cO00KA+ojod4v8bKyo94FTaM/omM7mARNpgzSmaQ1XdccamuN+8
	 eprogd/XDP6LRrXUraTOS7bjTXlWUggX7hooGT1ys6gLflg96pzt9fBfcOPAuQ+W+KfGY
	 rGTm2Qex5dKbfYDQX34MNN4bg5nGTe4sO8s5dbc1MEEdxT0WLQUg/JtfFZ0gXYLRoj4K5
	 kw7vWotxHfxnSJLClCQFUkcDZloMzPlN1zhILFJWrTkSHHyRhlDvWiMxy2HaX0aM/zJCo
	 Qw8r5yXHyXOfhV6r/TWzIjcbS7vckGGkUvGquvnNvTmMBPb7vJ9G6dC1wXUki3tWR0Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=sifive.com;
	dkim=pass header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=j3iZHNRP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790705907;
	bh=wZ2bGMe0KK9Ocy2boHuAgoU1jlVtI6PrZ+mcKJ5BHRM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iKyXEHEqOkPaJAeFxs9yyRQ3GnYhapch/8WqyI8dlf7cfhWh+abk8V2sWIMO4Rrhj
	 A3AAXKhTQlRgs/S08E1Zpza1SXBHiUvuJBsZ1WhzzLOu+7zhIApou0lpM+HvHNPMJo
	 a2qk7ovMVRoR1/5kY9fJR/SK+C7fcZmGcAJQAORKBg4QbpHAAvVn8U/Kb0719AKnTE
	 uFsFNiQ8CizCsCbT1Waaktf+1nltabKn8WGuX2iqmzIzcyyeg1t4GfFxx++qGpJUbT
	 9Z033SqY+70cmlMezfdGX/SBnMoqybbsWUlfRM4290YK1dCqoBKDLKDzdIqmd4oyvl
	 Dz1vvnq5TrCmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23A2980ED4;
	Tue, 29 Sep 2026 18:18:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 89C8014C
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:18:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B19E80ED4
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:18:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ffq-wEix-vIJ for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 18:18:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3192080DC2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:38::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790705904;
 b=RLFCt+DvK/wyzsT9AeDpGnDmkTgIIkBlqueq8Nkvc9FY8PmOeX4ekA72gv9HqmagHKVw
 7T0gJ5/jm36wb5wiboWUzU5Dlce5rGZj4ETB++ikQNfP12+YCqRUfgXfIsqq+2rR9E0BC
 xSj8gJgMyCUOgC8ItdhEbnq5c/IuXj3Qe8URwIUpVYOAOIfyROFnt1XCeMlvi9xly4KqE
 kXKHRCpyTS9L7XCnC1XsXe0GrTVjVTHIRnLYeuggkH47UUqDXvvWjDqbgoiOpnPuhPXz5
 4b6rGwXrbQso9x0yMB4XFMTLqJBA83qtxQaS3FHSvqtJbqAO4xoxLFFmeu7sJfJdV7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790705904;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=wZ2bGMe0KK9Ocy2boHuAgoU1jlVtI6PrZ+mcKJ5BHRM=;
 b=A3SSHmbUpPfOqbL4HLxrgVyc+/PuqCMqYldFmW8L1w+i0vMW1VdaHCy1b6clbxeRLNk0
 6gcsHemSr1uOx5OsdMucEjq6n4YImn2/HkcxfmvTQ7ENWDNcxZIH3gzwR/zT46IWezwCc
 Sux1fcWfNC4H3O6QQ77fK2y2kaDsyymhrkYoWK++xKwTM92AwEuj7yVRmXPr/lEDVOWHK
 eeQYxdBddFgy5o8oNVwVytA51eVL545yICDtal2znVfAruivLcYu6a1SfXaUhfInJM7cG
 u9iHL36TMlqEHygvgUL4WsCC2lmInsvolwinKW33vUZ1VVnT9q083PUE42XHUujcymA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=sifive.com; 
 dkim=pass header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=j3iZHNRP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:38::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:38::e;
 helo=mail-lr2-x0e.google.com; envelope-from=leo.liang@sifive.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=j3iZHNRP
Received: from mail-lr2-x0e.google.com (mail-lr2-x0e.google.com
 [IPv6:2a00:1450:4864:38::e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3192080DC2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:18:22 +0000 (UTC)
Received: by mail-lr2-x0e.google.com with SMTP id
 38308e7fff4ca-3a76cedd9baso6422871fa.2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 11:18:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790705900; cv=none;
 d=google.com; s=arc-20260327;
 b=XRoMEfPcAjwOiyU0Ktnfi5DwKrlCHiJ1eLkFAmxPBSkklSiW8KSbZCoIOrOlillqhJ
 pHqnJaUzXsy9Z98Gc9Tz6Oq4F+IKcUK0CyFtH2LFCP+A4ulJEbQX9hlJPk+MEcVzkBnM
 szBRsdOZdFT1JSqq56BP7rP7cligpj26PKMUG4qASIMBVqlOgTefkJrm5ir9ouJndlGg
 ADdgtstK1AQjcdr3t/K52S6e/yEp5bv2zPmYdS9cvhJgQ8ITam57ASLB3vY9n9YedtUG
 h2A2gudDKZJAVfnqWOG3xjKldoC4f3UxNJYxHW+PGIV5ix3um+0o/hsRPFko+EV6THLC
 L0kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wZ2bGMe0KK9Ocy2boHuAgoU1jlVtI6PrZ+mcKJ5BHRM=;
 fh=pHWjJ39YrSLL8k+QF8GZJ80hZ1Nb50zewFF/EN4SIMA=;
 b=Lpc2NQjSBBO1neLHtm3laJduZFahPiSdvWKRdX35C2ZNQFagPwrBqZ3QO2MkRWSPMF
 2SIKFbsZVnhN005KdCYvSCthh6DXauXOMpf60Y0K08mXZJWHW0X3gkSVKUGA/QR88qb3
 NHOKXFK2WLfadmnv9IhBJWiQ/awn3l2FUBj1/NFUtyL406ZfPQ6tV17wktpGmQsPieFa
 svLdGMsXPGrVXOt2D6iVky4oHIwGDsDMwgVt8d3mezSBCYwMzKr0y89WqzNY1EB2LkOX
 1foqMdsqQyHNqUW99RNnhifApuAU3GcDY5aKNRWZ4vLSEhVxAZ0WObsBxlPzwZCqWoIW
 KcKg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1790705900; x=1791310700;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wZ2bGMe0KK9Ocy2boHuAgoU1jlVtI6PrZ+mcKJ5BHRM=;
 b=j3iZHNRPnQK9ia261I7eZn4zf7G8zrcd8CCXUO2kX5L02CkUe/Wh2VBpOqnscIlH6V
 ykC6aUXDlohm6jPSZjn8fHWKVk9m17KFVDPeXWCk/vZ/+4XT1fOCCYdNCZOt/SRXPa7f
 PaQ68OH08swxl7guU33DBSlJKYaj8luV9DS44BugFccgAeMB4IyJy3QoJs+5Meq9BulY
 rgZkS7DV+tFDPkNXLJ5hr1oVoUf34Sjlogn15kCmrTmq4+ivVHVmFs+JI7U9mQ0NLi34
 B2D+uDJjIiIzTkUTv9u/Oxcv50nXG56L9OEYk0JYEGlpkEEtmkQ02a2kBxSOmJGYIe+n
 LeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790705900; x=1791310700;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wZ2bGMe0KK9Ocy2boHuAgoU1jlVtI6PrZ+mcKJ5BHRM=;
 b=gYAR69zYbqCx3ZcyvSh+0A8VoDz7amjlSwPFudMMS/8ZgjYOxuhhAzAWt9oHFP2cgE
 2pyuTZejEYKG9Wqs9hkj0zgIdoE+CktV0afxxOggRZGRfcBSfkECypbh68XudForFjd6
 y5r1/FDMgHzCFxjmVC5rfPjLfc7e6HnZGbhxXL9nYUR5UJNADw6eqto6Xpbe4H0345lL
 krN3ufQAVqLzgQkCv02KBLm38cKo2C7QJhLDfXdB+rM6i8IuvAyI8MROB8Q/qOCThYrE
 H2Aj15xzaSRVlG4p2ojUbqLW/hg0C9w23AsWizSU3+0CQoyRy+PfGcLiM0W48BnQzY0+
 dcsw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCHIo+tP4j7N5S7OGeSWzBOSn054yN0HhuyPLWgH4eXSb7A3Yx6bpYYP/Z5/5NJ7UqXwNPXWU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKSTRaexQmOvw4JwtDxMrxmlxg+x7+LbcmhjR0QIU0C+/o/vZwB
 kxWWRXrlr/DmeROsi7+q8q025CA9WWhJtP3HIVXiVhVknoAOQY/u0vLVM1kYCwilxSy2L5aJPqI
 53Ok1ZcbLy8JrY0uQLl3xa3MUCIVmd+bNmc13L0sdxQ==
X-Gm-Gg: AYBFou111iyuct/4sFymN0304tWXmOXBa9ZV7LSg1kKeMmnZe1Ata+t+bOu/4GY2b7r
 qgKuiroKcttsOzhRSG/69DMlK/VhJPviXWNMbqNo/cSXtr8bFLWnuZv7KvY69NgzgXnQ+tB8kik
 WFJfKWKFya4F1cgyuuF0GvYq/dHpURptBxapqVrCdb9oAsNNV691jgSp068cHiP1j5GCj0dQjT8
 4xBm1dQpPCnlRH1VaSA64rcVwmzORKbNH3N8AL8a10Dn1h7HGYkWjBtaxRozN6/wWAiX8GvoRHn
 SfXIZsh0E9uD4kTSaoIgwJkrZK4jwjPAbXSzw4h5thESNd86uihrTyfztw==
X-Received: by 2002:a05:651c:a103:20b0:3a3:74b9:8a79 with SMTP id
 38308e7fff4ca-3a7719063b1mr649251fa.18.1790705899919; Tue, 29 Sep 2026
 11:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260908221740.27927-2-me@ziyao.cc>
 <20260908225112.GE1764417@bill-the-cat>
In-Reply-To: <20260908225112.GE1764417@bill-the-cat>
From: Leo Liang <leo.liang@sifive.com>
Date: Wed, 30 Sep 2026 02:18:08 +0800
X-Gm-Features: AclHuK8_h3eJp3tq0IfRg3cuoM6w0Er2q30YG1TN-gGf87JNtWiTDp8Nwt2MwSY
Message-ID: <CAC7DN2D2hS7AuDOmn9P+T3wBB_oB6qhqfbvpkiX6Te77QX_fng@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: Make RISC-V entry cover all paths
 containing the keyword
To: Tom Rini <trini@konsulko.com>
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Yao,

On Wed, Sep 9, 2026 at 6:51=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Sep 08, 2026 at 10:17:41PM +0000, Yao Zi wrote:
>
> > So files like riscv_timer.c won't be accidentally missed. Also remove
> > hardcoded paths that will be covered by the pattern.
> >
> > Signed-off-by: Yao Zi <me@ziyao.cc>
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>

Thank you for the help!
Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>
