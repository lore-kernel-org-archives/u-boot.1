Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECAD606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 06:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YbDbNxG8;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OXtphlFT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6EA4F80D66;
	Wed,  4 Nov 2026 06:47:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ilFy6d23HmPg; Wed,  4 Nov 2026 06:47:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 620B180D74
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793774866;
	b=dUMVfGrBwflVKwUrzogUR6EfG1oGKWoitOVXgWK2htx//e7ufi+MoXa7auYKd4aVDvWg
	 tJo/tsqT4aJEJv/AlTL9YeTq61H2uRqnn4+WMG67HH8yeEtY/WozWXeyUunSP4j3qsmQQ
	 PkgTRmF5JGTrAH2kYPyLBU6z+50MopDz0nSDitZxvLpW22w3bnXbmrmnCe6BPDAttrAUx
	 TLDtwayTlnVpl5zToqFzCSTLaW+aprAcNCVlvgucJjdaiZsoaUCsdT5EcgiZsXtJv9/4n
	 Eo4OP+9hR74EQBUM6IC2Lo5nzTXOfyviFrOqpDF/qWb9lBVZlqKjyE2DpGu25GGCogg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793774866;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YrT81sixhSYJL9geF7mgRPe417envOdzb1Q7i8CDULg=;
	b=csr69hyc12LNQ/1ZIjMnsUnxIVr2UoSjTYfBclS+r9k4CVs4DC80DaJt6zYAPzvSgQkE
	 R8FIVGrF+7KL7VG2xwI85S3dbJosrc/cVkos0WRPPYusvggZ5L1aB+ULC6oVuK7WcWc0N
	 Mn2lCVI2HVPCvKj9FcuwZWvKUDqdM/GupE1ENA5mhcC6y1zbRGU/SkAICgZ+1ucEPE8ry
	 CBkjvKLqE9pgDVZiD+QxHQYLmO9hceAI0R5H4Ko5IShLjoYgOy/xLS1m5fLnxwryTM/Ih
	 GCmgr7avHVOqzxj+UFGN4fkHtcrRiP6lR4wFY9k5XcSkifk7UwYv2tliJS6tb12g/wA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OXtphlFT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793774866;
	bh=YrT81sixhSYJL9geF7mgRPe417envOdzb1Q7i8CDULg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YbDbNxG8g1qtX8GIS66xpg2OlnsU++F4ZhYdyf1I7naXoP1kqxWSkMivF47eQlSbe
	 JI0IoeM0tf03adzrZSZFMi7L98gAmbE4sC6vkV4IY1EV8Qv5w8iWEqaQPYRBs91ptF
	 db1wAJXhQRPsp6xsBgzYRuz/SCptYjMLbRSgNoKe9IWK2LT6PH4TZTzbx7z3AcHGKp
	 pmVfF9Qr7ZWneG16uCg3lVFeHCSgt34O/iPYLrjykYAbuMtanp2B7ILkFjiIxpjbpQ
	 KpF+T1eeFF8puM+eU2E3v5YBFb3bds2Ztj3W8gC/bvj2tiWkp9ipvrL4JTR3x538c9
	 EVr6FcFrOYr4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 620B180D74;
	Wed,  4 Nov 2026 06:47:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 003AB341
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 06:47:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D92B380D74
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 06:47:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nq2JIE7zp70k for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 06:47:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 918EF80D66
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1136"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793774864;
 b=qjxXdF2XUci+bCvVNDxQmjNl3oGFs6nNkk3eT4toAIxthDILghr3v/bdFPuvRBXKFYjA
 cbGofehYe/eonAvUhj2pFi0hWqKNQmMOcmWhYFUD59yt70JLgSFRKdOCrAJTTnZRjBRzk
 F4QTCOBk7C+YvnyX7eCgejqR6fYjH40pw8l9QP36gmGqq37p6YtIYvY0wC7wxVqQ1Rrfq
 y7kDnZzwsivzo0a/e+uob/TwqayoO7pqobD86bVopw5OnaA9LzEhEdTcZNf2KP7NBL+GX
 wOcuTgyiMeKU+EOKvBIhD1qJGhP4zUB2vxPDOgXxgKH3Bnur4qDlGmvlbPKd0xnAz+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793774864;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=YrT81sixhSYJL9geF7mgRPe417envOdzb1Q7i8CDULg=;
 b=O0aRHKLYmeT5ekbBeRNksP2jF2QDuWXBvy4ZcBokw1DVSQvUlyU8ySkml8xlM5j82BD8
 tQcfC5gwSjTIC8yPeoI0feQPbsZKet0CZXSMGaP+cWUrOtZ4gT4VtJbmuLrMvrBVxKlcP
 Y+qu/QYGNAeUY1LIAtBplw2Gw9C5nJPEVbNRM8NM8VDFTzCPzRmzMNOF9+TCCujsoH5Dd
 OW+oI18UZhbgTTkQ5FdxhyQPt+HavAxWj4j/iI0Enf+it3YXydQkofwfcBKs3GcKjGv70
 JFjg9lqrur0i9nQ6kW0AzVcjdmlfqnz2wkoTA5E8G51qQ4bN0CRCNoIGefsUTtSMkjg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=OXtphlFT; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1136"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=OXtphlFT
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 918EF80D66
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 06:47:42 +0000 (UTC)
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8b30cbfa628so4708817b3.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 22:47:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793774862; cv=none;
 d=google.com; s=arc-20260327;
 b=DG0p1r6j7osYjimv2Y8qg2qHAcslwd7vli5ZOeUlWm5PUaNJxwlSaPQ/4Ku/1C4OIY
 PTvUp3QrfwoCG4Kk9JGN8qlhyuzeDuz77s+TSwmf1m4txIU5XRD4yy8oZVPqHBe5TFV1
 eM1NgBAAh+Ux6gj9Jlfa+kqkKt8f+SIMO3ymy0yXhn02O1zok2f9jVlyOxAApcWV50ya
 dVov8/Jrp3FqE0IAeeThkI9txHhxfsSVWvZ7Bf8UIHxtfIsGSsZ00Ev4HY5a5m+OsyoE
 1WEk9nOG9GwHTApA3/iRbKismb6a4MPChU3Y/GsOGO1e5SKnxP8+wgggNry8275cHgOI
 mvsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YrT81sixhSYJL9geF7mgRPe417envOdzb1Q7i8CDULg=;
 fh=7QWwyUnPAQm5WNln6yz2UnPVMLv30rqCuNC8nkM6bR0=;
 b=NbCgx/DhRZo8OSlBRK4MDOUBR2ktyGmlo8T6t4a84BI1XspzrWovp55z8AEZjVahCq
 1M+LzKNKPvsiXqoGk+bLLVGz/CA84wa6r9ApkkkSc1HKY+wa1rjkdlCpfmd0LZD09pdb
 VmdoiWcMK7lphD3wMQkh+5IWixvjG9WcF/utnbWtYoc+alcryXs8SXfN176wyeMHqMKk
 qPrFTDLpGvap3qhMVksMwUVLXSUALAqSj0eZtP24WCbOuxtT1lEic0CKI2iUhobnkLWf
 N6t9hDu1UppwWNcsajfYuGcBYL8XHLc3tmZoZ21K23wBd3wT7NAa25Bd5q9bl94kXLwy
 Xc7Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793774862; x=1794379662;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YrT81sixhSYJL9geF7mgRPe417envOdzb1Q7i8CDULg=;
 b=OXtphlFTuDoNsCwp9ufWqgLIWnZRzhFuPvn1anpa8jauilsAlckhouaVopSZqk8fWC
 XxidghX9EkEcRItVE6yq7qoTU2GaK7K14+eON6zb4C0MZko1cwYnmrcsYXXcskyP+04+
 KpNfYShn+P4oqZcXGhtwXzS8m1PMr6e2xsDUf7Kyi7fF6WkQR3o6KIzgeyOrSd+PHyPi
 qVSbOXzAR7+55/xp8TMan6wQGmLOsbAqzSisslwQL8HPn1TVhkv8Q5IUIIszTN2RWbX0
 x67frHws67TU2BjG0wVoSbS/mdfyB83eR3MbxDtBi4En5KdrXULFD+YiZQy/9AO/APE6
 WNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793774862; x=1794379662;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YrT81sixhSYJL9geF7mgRPe417envOdzb1Q7i8CDULg=;
 b=1ZpDNcbl1pwBgb3E3Nla6OBZwhZnh+wKA1btRuCPEZ15sSBXe3I8SgWeWyT1hehb2R
 z8wTyJk4APtGssZTGrU9VKJt5HObj4iH+l9cMX7Hun9Hy9DQI/AtrpLcuc6zABNkgtkh
 p3VJG+mdMfoejPokX4YPK4aN3DP0Fky3PE17t5Qh1cIahkq6XIZO+JlPR2vkCzmdGs64
 MyBmQ48giiUeffX8nh95e41TwHFdciz/n1dq7V42zv7Qc5CxzvyFB2ke+BasgOYNUbHr
 JELnnUFnwmHrQdONq62pk5wffMwDpiOqELiK8VT6wdyj01QzWHryni8Yr1lBWWMmEMBP
 iDXg==
X-Gm-Message-State: APuU4Z8D7SGOmDGtbmltVHaj4RatK6Wp+rWsQLbwSRwJ2+7iv9X2unG0
 hXwaQIRA2Z7MiRs6fhGmqHlRru81Q98Sw4bpv+SZ+1O4/KBq6H1+xPJtA2d9cGEZO5NI+a8CNsT
 M0FrhxD0Srm6irj8AiLP8xWW4I/wme4Rzr3ifUFzdgQ==
X-Gm-Gg: AYBFou31gQWzYRHaKGQ7vjFABB0R6JDtEE4vHaWnBBp8bVdf3US7BwAzeLVWIb4lcFb
 9c+tNmEMsTGsCk/zEEkHKl4UeD7lInrsyRTpYBCuicZhbHn2dWPtCjiGavFOG7xdnWOwqaO6ueM
 CU2ok/0slCFezU/pBjGeaUGCPureYvElZz1v9o/yIAv2ssPDitrBTvdDNbxrmtSGEzBDY+QnNr+
 MrDzwcLVi8to3ouVHSFZ82ey0gUvBxVIqebe2fZKoq+6yjf3O7ajHuh53qfHUqC4nP28X2su+qQ
 Cd9Wjif+eOtAy5XxO6dQZJANKUWgM1fUeoDYiHnlsSrDxAOPojrU/l4kKcdNd2eg9dE8s7V/4Gw
 oPQBPcQua3LBDl4iig9HtI6HxkJ1MroybH9YcIl5Zc6BIRnbzLgL/cCzB3yJ+ChZ6ewHgnnCmCl
 MZanqXnqs8AYJtTXDB6sqfdJgLex5ylHaP73sh9cdsiooZ+dgT/bIjgoGRw7QH9t0FBeb5+Arua
 rEpZnhyT6SrXGHEP/mc5dpG/26nBXMQQXqdXPCfTKyfIDWUXjyCXy2VHc1AUD0ByerwnUJ2q9gA
 b9zTNZ89T4nJD2vpn7cICobmByedD8GzchhuLlQBBW3sMICZGZiO7V4lnpvl9HdRg8aIZKnTVwA
 dnW5mUvK+Vy64BjCA5f9TWBXH3wNHeYeksiPYac0SZ54Z2wKYT6HtAoAj9yTW51NVNFR73sO0ym
 RPKwyKc2zPTupdx2CQf2RXe50brBWtImeR93Q=
X-Received: by 2002:a05:690c:e3e7:b0:89b:6b8c:8edd with SMTP id
 00721157ae682-8b2b676966cmr108640137b3.48.1793774861619; Tue, 03 Nov 2026
 22:47:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029150906.1558380-1-tkirchner@emlix.com>
 <20261029150906.1558380-6-tkirchner@emlix.com>
 <CAC_iWjLX_3RAzxeCy7HQHEy+fZS4Jm-J_E6wnv_QG5+DWpX+GQ@mail.gmail.com>
 <64f49638-bcf8-45ca-bf88-2e96e2d8d68c@emlix.com>
 <CAC_iWjLwGpmX3jfeo2h=ERDuYZo-a5scgBejzV_euCgazHimQA@mail.gmail.com>
 <a71d2e80-f36d-4e54-b85d-917a7d494a31@emlix.com>
In-Reply-To: <a71d2e80-f36d-4e54-b85d-917a7d494a31@emlix.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 4 Nov 2026 08:47:05 +0200
X-Gm-Features: AclHuK-gD1A7Zsc-jnL5aU0X_ExBcdkbWyg_a6fnYbOq9Ns1s6yZdHRBEiAeYcQ
Message-ID: <CAC_iWjKCJdvX-9ToZWcCNLhZuDS7iL8cTwm=6md42WBx2dEDvQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] tpm: deactivate unsupported banks in tpm2_auto_start()
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

On Tue, 3 Nov 2026 at 10:44, Tycho Kirchner <tkirchner@emlix.com> wrote:
>
> Hi Ilias,
>
> Am 02.11.26 um 22:00 schrieb Ilias Apalodimas:
> > On Mon, 2 Nov 2026 at 12:35, Tycho Kirchner <tkirchner@emlix.com> wrote=
:
> >> I would rather keep it as a fallback: callers may use tpm2_startup()
> >> directly instead of tpm_auto_start(), e.g. custom board code or
> >> "tpm2 startup" followed by "tpm2 pcr_extend" on the command line. For
> >> them, the check in tpm2_pcr_extend() is the only place where active
> >> unsupported banks are caught. With patch 4, it only deactivates the
> >> unsupported banks, and only with CONFIG_TPM_PCR_ALLOCATE.
> >
> > Yes that's what I was implying, but I wasn't very clear. Is there a
> > reason we can't move it to tpm2_startup()? tpm_auto_start() is calling
> > it anyway unless it's already initialized.
>
> No, that works. For v2, I would deactivate the unsupported banks in
> tpm2_startup() with CONFIG_TPM_PCR_ALLOCATE, but only if the TPM was
> actually started there, i.e. TPM2_Startup(TPM2_SU_CLEAR) returned
> success. If it returns TPM2_RC_INITIALIZE, an earlier stage (e.g. SPL
> or TF-A) has already started the TPM and is expected to have taken
> care of the banks. With an event log, tcg2_log_prepare_buffer() still
> aligns them afterwards. TPM2_SU_STATE, i.e. tpm_resume(), is left
> alone.
>
> The fallback in tpm2_pcr_extend() from 4/5 stays, for the case that
> the earlier stage supports more algorithms than U-Boot.
>
> I suggest something like:
>
> ```
> ret =3D tpm_sendrecv_command(dev, command_v2, NULL, NULL);
> if ((ret && ret !=3D TPM2_RC_INITIALIZE) || !bon)
>     return ret;
>
> /*
>  * Only the stage which actually starts the TPM deactivates the
>  * unsupported banks. On success, this resets the board.
>  */
> if (IS_ENABLED(CONFIG_TPM_PCR_ALLOCATE) && !ret &&
>     mode =3D=3D TPM2_SU_CLEAR) {
>     ret =3D tpm2_activate_banks(dev, 0);
>     if (ret) {
>         log_err("TPM: failed to deactivate unsupported banks\n");
>         return ret;
>     }
> }
>
> return tpm2_update_active_banks(dev);
> ```
>
> What do you think?

Yes, that's what I had in mind!

Thanks
/Ilias
>
>
> Thanks,
> Tycho
>
>
>
>
> >>
> >>
> >>
> >>>>
> >>>>   tcg2_create_digest: unsupported algorithm 28
> >>>>   Cannot extend PCRs if all the TPM enabled algorithms are not suppo=
rted
> >>>>
> >>>> Deactivate them in tpm2_auto_start() already, before anything gets
> >>>> measured. If this fails, e.g. because the TPM refuses the allocation=
 or
> >>>> no supported bank would remain active, return an error. The rational=
e
> >>>> is that with CONFIG_TPM_PCR_ALLOCATE enabled, U-Boot is expected to
> >>>> manage the banks, so fail early instead of at the first PCR extend.
> >>>> This is in line with the TPM_PCR_ALLOCATE help text, which does not
> >>>> specify at which point during boot the allocation takes place.
> >>>>
> >>>> Signed-off-by: Tycho Kirchner <tkirchner@emlix.com>
> >>>> ---
> >>>>  lib/tpm-v2.c | 12 ++++++++++++
> >>>>  1 file changed, 12 insertions(+)
> >>>>
> >>>> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> >>>> index 18ec9eb960d..bd049fed748 100644
> >>>> --- a/lib/tpm-v2.c
> >>>> +++ b/lib/tpm-v2.c
> >>>> @@ -232,6 +232,18 @@ u32 tpm2_auto_start(struct udevice *dev)
> >>>>         if (rc)
> >>>>                 return rc;
> >>>>
> >>>> +       /*
> >>>> +        * Early deactivate active banks with unsupported algorithms=
. On success,
> >>>> +        * this resets the board.
> >>>> +        */
> >>>> +       if (IS_ENABLED(CONFIG_TPM_PCR_ALLOCATE)) {
> >>>> +               rc =3D tpm2_activate_banks(dev, 0);
> >>>> +               if (rc) {
> >>>> +                       log_err("TPM: failed to deactivate unsupport=
ed banks\n");
> >>>> +                       return rc;
> >>>> +               }
> >>>> +       }
> >>>> +
> >>>>         return tpm2_update_active_banks(dev);
> >>>>  }
> >>>>
> >>>> --
> >>>> 2.47.3
> >>>>
> >>
> >> --
> >> M.Sc. Tycho Kirchner
> >>
> >> emlix GmbH
> >> Headquarters: Berliner Str. 12, 37073 G=C3=B6ttingen, Germany
> >> Phone +49 (0)551 30664-0, e-mail info@emlix.com
> >> District Court of G=C3=B6ttingen, Registry Number HR B 3160
> >> Managing Directors: Heike Jordan, Dr. Uwe Kracke
> >> VAT ID No. DE 205 198 055
> >> Office Berlin: Panoramastr. 1, 10178 Berlin, Germany
> >> Office Bonn: Bachstr. 6, 53115 Bonn, Germany
> >> Office M=C3=BCnchen: Am Knie 16, 81241 M=C3=BCnchen, Germany
> >> http://www.emlix.com
> >>
> >> emlix - your embedded Linux partner
> >>
>
