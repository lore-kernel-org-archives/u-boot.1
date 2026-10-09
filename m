Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A981CA5FED
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 09:06:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D47D1606C7;
	Fri,  9 Oct 2026 09:06:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RaV81pDo1TR9; Fri,  9 Oct 2026 09:06:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2E00B60727
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791536771;
	b=Kpu9O/glLOlRSU9tu4m0jgtSu/JhzSOTt+khuvAyPvjKfWcJFrnEbRO25oM+hne8/GpO
	 bKhi4fIhg9YwNdsEujlptApnQ4C7Wb0YbTK/LEmxs2H28wLh+IrsoND930ASAFqCYXI/T
	 /0taqSZfKtpNFXnnEXKz3iKZ7ecKi0dOO7DOsVH8HRAq+JABPYflcp3cFsSf5qsw25GtF
	 vui/XpK6hXxckbl6Fvsv0piD3IP/+1MGcZO68cK+fxURTHF8QvAp4spsNZb00LBicNK3j
	 Zth075Qb1IkHlVC0UQv1fEY+J33upYvQdIsOO+QDWwJaLy33c62DO9wR8zpJ2FtIL8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791536771;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cFUhO9PjnV+5tRp5kpYTVb6cXZNM1qEd53dXWT927M0=;
	b=PWAcJVT8qW8MhYqj6WDcldoKH1RJ1o4W9w2YpYevNkNrO8QJ0X4pwnX9xkAQpg16moFa
	 /8OpHMf7yKe+Ka4/mYfOBLOYVPS98b+7l0VomwTvY0maP5s382/QStEjBN4UKhOwZLLXV
	 TkG0lbitKoKBcePQITkEKgSlIB0H9iepumPwnqPNu4d/d++Cbj1IulWcrZbtTpegD1wNt
	 ZxyYZGe/hD59nuFfK+uIY/oVfrSBQow341FgCqrwCUiiPuMxXJdf1XqUgXRq/pXudz2dk
	 7WirIM+u7EPnWp7uVk4CQ1juBKXxgwWR4k4A9FqwMSLThQ+EmoyGxeonk/xNSblLPmw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791536771;
	bh=cFUhO9PjnV+5tRp5kpYTVb6cXZNM1qEd53dXWT927M0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hV88TZjjzMh/fl1398Vl0pgNfsYwHJWpOhdSbrFwuG4hAWxQi4DhJpPE3X3vttnCP
	 WAyrh/OS0L5s/PrPyITCqQTQNGJfpNLr7zm/yBnqKmJ6xOuxBpe3dBORnd6wqNEPIf
	 y4Zr5SaygKj606i20Ex2LJolRnWL8wOOg6h1WfwrQ3tKVuXTAcXam0/kfD0dlQNDrG
	 VP3ZfPAmhOg9L3JKxn9O0msxcXTIYNqSPdEr9HL/BT8a74S7rxq9ZdvccyLAP0tBL4
	 FYAgl5r48PEUsf91TiiIKtnNxVSBfaSy9txWbqEaw97lqCmEmH2VX6S+TK4aCX1lRc
	 H7Ne6ErkOLIFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E00B60727;
	Fri,  9 Oct 2026 09:06:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6445075
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:06:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 554BE8146A
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:06:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Eh0qmzxLqB3M for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 09:06:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5C9E4813F5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791536766;
 b=UcXI30xxmh6/1mEjd2OFVXbd2+/uGdx1p0/rxRN9zdeiUs24HggkN7hxgaWd12Qz1I19
 5ebi6qBZvAirn9azYpksBQFf9n8BeU1HM9s1lXndr+NcM5RPckZ5dHcIadZp5pUkKxdhA
 Pu5Ltt0s5nADIuYxOMuW1KcyUyY/YZ7chyJoZgkbma6IA1geXebQNt7p7wl5letq/mDS2
 q3R7PWd+C8RRkVP5lUmEOcKjsFzGeRq+EDL81BDSbtGHCFCfceWoRVQZfI1FYyisJPmjH
 dIpug1oe5fVFWZfF/UW8iaMPvB0tAp21UHh03i5ELEja7E949T+rqTDnlC5FyDc7wzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791536766;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=cFUhO9PjnV+5tRp5kpYTVb6cXZNM1qEd53dXWT927M0=;
 b=BXpU8Ous0LfF75FUJpRWKQ/eCfEZlE4iEpV32gaqG+kZEdsDuP0E14Y9JNU8cJmln6i6
 ZNp6nn3OkYdd9hZr+guLg4gEkmXx9GitU5MtkraMmISi9neQgOrHup2s3Ygv9C8vwt3Mo
 zGiwXif9T5HOOrTfoWt4lUKAAzChg2N99GjqnR66/5mpLTuC0DBvse0xnR8D3Zn6ARXGg
 kAJCcnCao68e2QUG+uYJXHfNTU0cE5oT34TGGxMpiCRD4/oyiWtcJLZ0CnWhoRQUA8fyS
 5aSBBgFZNgOoeX4Oycp/qwdFsvTdLuSex5cWeGGtuYA37q6QQ7kE07BlN3nUtv8I3HA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fQM5wFmk; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=fQM5wFmk
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5C9E4813F5
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:06:05 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a166199820so9439395e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 02:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791536764; x=1792141564;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cFUhO9PjnV+5tRp5kpYTVb6cXZNM1qEd53dXWT927M0=;
 b=fQM5wFmke1stMLIZrnI0rVP79KmsyCyDPkPZImgpLnWLjLwwm4x6xxFh1vko4kNwhs
 78TFtaqfirZsDZrlWDsAcCTwzQrpxFo9njrdCjKd5yLBhpT1HkSP0n03wPK27H+ef5ZG
 G0Q4Ms9GLf+pYO6ANl4G3d+koIMIAGFECuodRQ3RmZvBAa1/IRq6lTprov89LiqOXGuv
 Lh8uwVDQYKlnDmoRdkTiDDkKKoOZOMFNo/eSeZMdDn+1mzqpZctx+SANbyHpTbTwpNMK
 WwgI7KClNKpIiuRcmJS51v5BPKf4VIjvSdoO0bcQXh1jAdc9UjyoM8ONR8ktDqwyTSCC
 oGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791536764; x=1792141564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cFUhO9PjnV+5tRp5kpYTVb6cXZNM1qEd53dXWT927M0=;
 b=T1b/djYxIanD+BkIy1berJtLUI6uE0fHBInOMRPPiSR1qmt6IDvWEG1neGiUjZLb2S
 aJqGzy3DgT4Lusi56QmmjRDgYZZ470PLQ6etkQiy1EMRhaKyOa6OL9m5KiS0BdXPRXnY
 eG9uvivNcdKBO4otFN7gJkyGZbuEjSZLXqSR3MSWiZgz1gaI73dRswvTSl1cGk9DsG6V
 lJjhrYEBkAji5tgczIstlTJ/X+g36NbhA3kd8Nm9d2Q22S3rcjikYcZ0yQI5vnJ/a96C
 mwXPrPhA57YJyAaMAbhelbTG1ijDULbGW4FMJJVgpONetBxNM/0/osIGrn9klQpxOKqs
 IRcg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzdzi12+wIR79VHYzzxH6JDGGeG1Dm4j7Wvf5JpYzWBofiLoOn+jNQm4MwXu5MuEiBntOi+rbY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lbSv4f7X6kt2FI//DMBT1nzkymXbChb+hd9jpqh+22jwa36ZEV
 pZECztJUCjSItdEcEkmakXrrZlwJ0u+LRAv/yol0HiQ3H1Mq1EIMvNhi
X-Gm-Gg: AYBFou24cE7O7KeEaExFECJdjIqht5H5qFLJIx6GIbUCD2+CPET7Q8+ZhalWWtoTqrN
 dhXDvyHTKXinE8tnIgYJVshjhMjVf5jwXBvDSz1TIFvbK5RCMqBS0efLJujhxX05HxOWukCVygU
 GVd7XfShnQ/BrIR3J5W2vEVcgpQQzyQpqObP5mJrB1MRBZCcCTJ4J9iEImzv7cdKdgamZuQaFxh
 X8snQfHEeEvnrbjfgmIzlxs8TL3EG4NAoDY+IDDVg/NO4JZzsmp+3zRt2rdHdxfSySntTKDAUTU
 lOvXvq5k6c+Zqa+NaWHkcXDT4+fj1CYgIqCxa3S+EDgPF5mxW+lNF6+FWQ8C5MMig/llbmAuHD8
 C2wdGT7fN71d1jS2oDPiCnRWit9/C2qW/8UyM6ldh8/BYX/ZSwmbDgzv8s9uHBAcPEHrQXHRb+0
 i7s/9ynCsaojAwyVMa6T5Yiw04EVKzqQ3O1N7VZMfHTl730Uib8K65j3DOelHF73A23b/yDKH6S
 SgB
X-Received: by 2002:a05:600d:82c5:b0:4a1:6282:1cf3 with SMTP id
 5b1f17b1804b1-4a18e497a94mr25363065e9.9.1791536762831; 
 Fri, 09 Oct 2026 02:06:02 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18eb4485dsm61347135e9.2.2026.10.09.02.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 02:06:01 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: Re: [PATCH v4 4/6] dm: core: add ofnode_get_alias_seq()
Date: Fri,  9 Oct 2026 11:05:59 +0200
Message-ID: <20261009090559.985466-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAFLszThvoDY2imKOv_A8W7kxyAJJjNNjRrNP5Vy5Uht6AfwDOg@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Simon,

On 2026-10-09, Simon Glass wrote:
> The checkpatch remark is for reviewers, not the commit log. Ideally
> this would go below the --- line

Will do.

> The two branches handle the stem differently. of_alias_get_id() does a
> strcmp() against the stem split off by of_alias_scan(), so the stem
> must match exactly. fdtdec_get_alias_seq() just does strncmp(name,
> base, base_len) and then trailing_strtol(), so any alias starting with
> the stem matches.

Yes, and that prefix match is also what started this series: with
"usb" as the stem, fdtdec_get_alias_highest_id() counts usbphy0 and
usbphy1 as usb aliases, which is why the two controllers ended up with
seq 2 and 3 and indexed past the two-entry tables (patch 1). So I
agree it is worth fixing, and in both functions: a stem matches an
alias only when what follows it is the number. It is a separate patch
with tests for both lookups, but it has to come ahead of this one in
v5: the negative test you ask for below ("test" on /some-bus) can only
pass on the flat tree once the prefix match is gone. The series still
follows the PHY phandle (patch 1), which does not depend on how the
aliases are numbered.

> I think patch 5 should pass 'usbphy'.

Yes, that was wrong, v5 passes "usbphy". The header comment will say
the stem must match exactly, and the test gets the negative case with
a prefix stem ("test" on /some-bus) so the two implementations are
checked against each other.

> Since the flat path now uses ofnode_to_fdt() rather than gd->fdt_blob,
> it would be good to also check a node in another tree, i.e. a variant
> using oftree_path() with UTF_OTHER_FDT, like the other *_ot tests in
> this file.

Agreed for the flat tree, that is exactly what the ofnode_to_fdt()
change is for. On the live tree there is a gap though: of_alias_scan()
only runs for the control tree, and the other tree of the tests comes
from unflatten_device_tree() alone, so of_alias_get_id() cannot know
its aliases. I see two ways: (a) the live branch of
ofnode_get_alias_seq() handles a node outside the control tree itself,
by walking that tree's /aliases (the control tree keeps the fast list
lookup), so the _ot test runs in both modes like its neighbours; (b)
the _ot test is flat-only (UTF_FLAT_TREE) and the comment says why.
I would do (a) unless you prefer to keep the livetree side as it is.

Regards,
Mehmet
