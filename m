Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A592EC531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 18:04:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 554DD60B99;
	Fri, 24 Jul 2026 18:04:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CEk4EWFhUdhG; Fri, 24 Jul 2026 18:04:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A8FC360B12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784916290;
	bh=gE0HbOdgTwqEzSEv3U9TG4CFOluFTM7q2YhviArqQMI=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=qseMUBrJFpwiU8SDX1VFCWSPuzWFsPjHlEfprbECjBAVg8YXy9bObSXC5WB6k3Dxd
	 K/qQzG1O720R073r0JSf3kotza89/jKLZZbjyDGau0jJK1mky5xkPtchfzPWF+KWy+
	 bp+7y7WkoNgbDmwJPBHwGofXlwBtJ62uehWvccV2Y7Z4JXVq6/EiwDqT9zg3q03xZ1
	 C3s3bOnTTc3cvPKW9QbmX+bS/iJc5h8lC7iY6VogW6ZJZiCws6P96vQiGVEtR4/9K2
	 XkgC8GHEh742YhSV7v7FfQqbFDzFKoHGE9RWs/sJskYxZ8JSMJkGopREgFp4a/HJbL
	 pVXN0Jrc0IgYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8FC360B12;
	Fri, 24 Jul 2026 18:04:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 621E43B0
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 17:38:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 47A74811D3
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 17:38:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aP6Aub52_O6Q for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 17:38:25 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=wsparks@vulncheck.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BCB8D80BE0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BCB8D80BE0
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BCB8D80BE0
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 17:38:24 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80BEC846A4; Fri, 24 Jul 2026 19:38:21 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BE5C800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 19:38:19 +0200 (CEST)
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5aea0fff535so800004e87.3
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 10:38:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784914698; cv=none;
 d=google.com; s=arc-20260327;
 b=bzSg8zSevGzsJL7H16AdiN/9K106RymnKgcsmZ1lXdx/flUAEHVt0dQZUesT7dzXjX
 ZhkTOs7izXllk7umVuAGEdIVIm6lVxKJTuGrQAQ9nNCCCguAH+6qmkvc1gfFDcKH5V/2
 65BdDC3vIkcYKZQxqrlh3CACbdq9gn9fYEsfyjATcLuhbAQpSmCPRduBrA3IShCKrjFZ
 oIIcFpyGbtriRQF2/eocpqZIn5al2d1/Ej/bdtb9Qev+wYMUtt1SWAdmF0cBHo8dOPUu
 3ubtD3gH9BF+1h3Qc4TamOKwGvMjTVHo/peDTsk1aXyOPgSAf5lGhau0gTioE28tLuH+
 iulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9Jb5dic53Y1+U/EHr5HxgZ79l8ZwGEKhOxhy+O3yE64=;
 fh=/g40BgdrLNbtiiNSOOrdXjdUjK/U+BWZuEuCHdyLWkU=;
 b=HL5E2Okdoqs7nGJk9/dPlnbWvHDQ0rtI3d9oZ4Wayaoc0IyeQ3F2ulsgpCxFKMADjm
 gqo8dXaW+uzLY2v4AGBLZOVeAuX2Nx3ynkhsIszRzVJHj2onJ/F8jPz5eGSYzGW5fRVM
 FulWp/JpI0ahvDGumaJL+LTGzMJnzg8Mq/SK0BjnTdN3ey+iJ83gHR4Ez30RlDxZRuFM
 q49kJVlDJJb4l4cQwFIFpiLoV+jR2fWkSgjjmCP5XywKcXphypK6sb6VSvOrLPij0/jz
 LC4VQMSHlDRkfGVsl45wcKLpRuq5mIRBGu2NU7JaIAtpzwpif4PEfUSj1fy86M5S8LM4
 5c6Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784914698; x=1785519498;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9Jb5dic53Y1+U/EHr5HxgZ79l8ZwGEKhOxhy+O3yE64=;
 b=ghqIlm/SJLhs+9I+EfMQ2RP6Ag1J8SSqdp2TH5AuomSgIZjrRK5qxcYk6m8u1bpVrt
 4OxYhfOI+epKrCZ9I7vExN8v69wQnTPeQFabLBnwLw/Qj+orTr+Cdme0xndFZTAVHNRj
 E6FyxMGrfcYs4uHCA3AjzZXsQ9ljmo1V4VQS+jRmtOxzrIR9PVxqfOBQIxOTJqtStx+R
 CcLsC0G5YLKzaESuxzYqt0VmRfZgonI8YQ3wQuae+JIBq1VPbKx2h62KmTaQDIafwjkT
 xC6v7b/jGVjGJ94XXL3hBxeazBo47Rncek8l8DsFj8g4VWOJjiC2nCYp2wg8Howyq6FQ
 Bwug==
X-Gm-Message-State: AOJu0YyQ0nOWJM4QvyC6UCGUnp5SjeiOE921F/gGyWxG6v0pFl76t/hg
 6K0piGvM7FRKyonPW9Elt5B2VSrKFSwsdtJPrsnCW0JfIS0MnnNtbk97or7bFiAjgkyXOT1DaVi
 PSiNTquTaFbdLAFXEe47QG+aPOo5l/Mu4QaUc8dAD0g==
X-Gm-Gg: AR+sD13wd4BhKeKiBaKDVmiudhKquuYq2oKqPcg4Okf3nnL/S+jcNGeqdf0CidZK+gR
 xAi2nbaT4Rl7+tQjeQRcrH1iMsf7VzzmxCsLzKk+5cQOB2WOXTjtQb8dWVnNXpYE5qNdTS18/WJ
 CYeGWYfJBPfYdfvkrK3u4sjMtLu/sgJgkUr0VxcvTsh5I5QqPb2LKrHgoxozvYWieD0CXNNBdXO
 Q0BbYLUSyDLQlGXnrj87mjeKHYkiGEoN+ZSKPjMkasQEko3zAOtpZAlkopbuE0j4q1kiIhIYX0l
 dSY7DOWSzA2AIXlj
X-Received: by 2002:a05:6512:68a:b0:5b1:5eea:a576 with SMTP id
 2adb3069b0e04-5b2b2e54622mr1986373e87.21.1784914698234; Fri, 24 Jul 2026
 10:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAA1v+SgpU6iU_WZFWN4ft1NveJHM47zSk+KPLApy9hogOKDe9A@mail.gmail.com>
 <2062cf5c-31da-4ccc-8ef6-3dadc5a799a4@cherry.de>
In-Reply-To: <2062cf5c-31da-4ccc-8ef6-3dadc5a799a4@cherry.de>
Date: Fri, 24 Jul 2026 13:37:42 -0400
X-Gm-Features: AUfX_mwTNQDkBTTvcPxBJ95vIFMI7IQ0R_5Nn-Ir-GgTPJoeZJWZnMyuvuYDloI
Message-ID: <CAA1v+SizE76J1gU2osz8xC_7Uq=Mx6W0omr5C+3ph-8G4Ar6dQ@mail.gmail.com>
Subject: Re: Coordinated Vulnerability Disclosure - U-Boot Multiple
 Vulnerabilities (3)
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, 
 Disclosures <disclosure@vulncheck.com>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 24 Jul 2026 18:04:47 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.30
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vulncheck.com; s=google; t=1784914698; x=1785519498; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9Jb5dic53Y1+U/EHr5HxgZ79l8ZwGEKhOxhy+O3yE64=;
 b=TiW3EPjZJa3EaXThF6XQV9oIyAaPQKnLH9JxhHQYTKj5xhcOnyVghKlonb3cEPNm7V
 u6LAXQLfRt6RuTWWBI2M84DQCwKaqYPncqby1D0RIJEi6hM3NrmXdH5lsmsfQazwM1Jd
 3ijLylmt2JDF/Dk8lUZaFsoJXGp105S8/sXuo8GcqoVuerY3Da29p8gQ+tfWjR4fhZt0
 nJD9ch3JW1gamhxon5DYq5NvQXInnPpGc2+F0Gc/kiCns2n8ChXKnLaQsO30CZthYIXH
 zPaUuZHiw/OyfN+V3nbx3BXgLkP1wJHa9h6PfsmUkgWsvcXj8vr4hHuzrmAhQR7XC4bN
 x3cQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=vulncheck.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=vulncheck.com header.i=@vulncheck.com
 header.a=rsa-sha256 header.s=google header.b=TiW3EPjZ
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=vulncheck.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wsparks@vulncheck.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=vulncheck.com header.i=@vulncheck.com
 header.b="TiW3EPjZ"; 
 dkim-atps=neutral
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
From: Wade Sparks via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Wade Sparks <wsparks@vulncheck.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hello Quentin,

Thanks for reaching out.

For some context, the vulnerabilities were originally privately disclosed
to the U-Boot maintainers where VulnCheck was then requested to disclose to
the public mailing list:
https://lists.denx.de/pipermail/u-boot/2026-May/617853.html.

U-Boot <=3D 2026.04-rc3 was the release last tested by the external
researcher that discovered the vulnerabilities.

Thanks for letting us know that CVE-2026-29009 was addressed in commit
d669401 - the CVE record and VC advisory have been updated.

Best,

<https://www.vulncheck.com/>

Wade Sparks III
VulnCheck
Senior Vulnerability Analyst


On Fri, Jul 24, 2026 at 12:58=E2=80=AFPM Quentin Schulz <quentin.schulz@che=
rry.de>
wrote:

> Hi,
>
> On 5/8/26 7:20 PM, Wade Sparks wrote:
> > [You don't often get email from wsparks@vulncheck.com. Learn why this
> is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Hello U-Boot mailing list,
> >
> > I=E2=80=99m a vulnerability analyst at VulnCheck <https://www.vulncheck=
.com/>,
> an
> > exploit intelligence company and research CVE Numbering Authority (CNA)=
,
> > where I'm one of several folks who manage our coordinated vulnerability
> > disclosure (CVD) program.
> >
> > An external security researcher recently reported several vulnerabiliti=
es
> > <https://www.vulncheck.com/advisories/report> impacting the U-Boot
> > codebase (discovered against release v2026.04-rc3), and VulnCheck is
> acting
> > as the intermediary and coordinator.
> >
> > VulnCheck follows a 120-day disclosure policy
> > <https://www.vulncheck.com/vulnerability-disclosure-policy>, meaning we
> > afford vendors/maintainers up to 120 days from the time of receiving th=
e
> > report to address the issues before publication of CVE records and
> > third-party advisories. For these vulnerabilities, that 120-day deadlin=
e
> > falls on *September 5, 2026*.
> >
> > We have provisionally allocated the following CVE IDs, which have been
> > shared with the researcher but will remain private until public
> disclosure:
> >
> >     - *CVE-2026-29007* - Out-of-Bounds Read in TCP Options Parser
> >     - *CVE-2026-29008* - Integer Underflow in TCP Payload Length
>
> Unlike claimed by your own advisories (U-Boot <=3D 2026.04-rc3), these
> aren't fixed yet. You've also linked the wrong articles from your own
> website two of the three CVEs you created as a CNA (as can be seen on
> NVD website).
>
> There also are patches suggested for the two CVEs listed above in the
> "external security researcher" report. It'd be reeeeeaaaaal nice if,
> when reporting vulnerabilities and patches are available, someone
> actually posts them to the mailing list. If none are available, please
> try to motivate reporters to engage with the community and propose a fix.
>
> >     - *CVE-2026-29009* - Buffer Overflow via NFS Symlink Chain
>
> I believe this is fixed in commit d6694018eadd ("net: nfs: fix buffer
> overflow in nfs_readlink_reply()"), available since v2026.07-rc2. Your
> advisory and CVE also are incorrectly generated.
>
> You have received a separate mail at support@vulncheck.com with all this
> info.
>
> Quentin
>
