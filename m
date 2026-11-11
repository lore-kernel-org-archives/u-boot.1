Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96379606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 01:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M6gNOr4g;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=IgANqFJ+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D8AB60A92;
	Wed, 11 Nov 2026 01:23:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8BMn5w4UqcsI; Wed, 11 Nov 2026 01:23:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BA7D86088E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794360224;
	b=cLWtG6Nw3UgAbnSNljnz2EyJg1FugkhGTKoMYmYZMee0TdtimJbtIl3errAs2kXsA5rA
	 zPIKh3hTQVjeb+A5RiLWpCMSvig3ELL9Q9eVa2uMNI1iMISx8G1UBFkEOp02gCptULF8S
	 98ZpreeEwaetE/K9j/mfpmuYDgHGOSV9djp0+94t2QG+/Aw5P9DjG6d2UoPgIpjYHec1H
	 RMX3rrBVZZiuMu0tocRERbUBL/LfkKHErrFGszg38dZybpSE0K8Djk+choNFVzCdKTsY+
	 UcsXNMAU2xeqZ6v2+LnX/EG4nh2uFjR2sih1GL3zy030XYGv6zMAqj/EPCscEukJpZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794360224;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=z0C8X3fdiNB9JoRZglij55rB9c38iuFoWrAKqPA4b0c=;
	b=Nj0Q/ZFwi7hBBT1/1Gb1PuXHM/c6ZkntcdrYNXJmHeg3nMctfzQ9NwNGaEhHXxtcYH7T
	 D0chJzs0L/4oLzoEpUDk4qV6dnRkuVfeOeT0Irv6nqpHxLelP5uyXTMuSx0cu6D+BeQlO
	 wR+5sl7WLCoRYbkowye8KOzVFFNYcAJ3ME+enPOOBJ87RZ8fd/Zt/zacgzkU8yXtApnuh
	 qn9z1/woQaHMVPr9fa/iuKHSJ7Xj19BWXT4tKCxgS9djMCESQWP01gudFRMwH7JJGXc0E
	 Jz1TLDalukljsuzvRjxdmGFMbZ+cIiUsRWE8wHml8HBDWHcXbNLjEIipVBDdgCn9L/Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794360224;
	bh=z0C8X3fdiNB9JoRZglij55rB9c38iuFoWrAKqPA4b0c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M6gNOr4gGdHM4LWyvY+PC4hTonblkeyU+MJUq/fDbw4yr46xb9J9HLS8FzPY/6SAo
	 /cQg1OGpNiUwEFNDLF1441FNnjhd9b1fFnfGRizVT3ZHZBZOEaBibdWCIwcoxGTK1r
	 +HY5gXbLiILGV4VM8zPH+WidFffdh3JtXXDsJSWVz0f3kaGFVilH6B5OJzFh8wNS1v
	 9QFgBPFzbdJLNuJmR0f140CdwgPSroJUjD+Tzu6b1zlp5qSG8aGpg2IUR1GXXzQ2n5
	 Mv33KWqskORicw4OUvpZu5okBwlq+/yczrvnBGuAKzhKkPjzRI11qW2K6zKUfNzqXw
	 Wz5V/huPOdVdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA7D86088E;
	Wed, 11 Nov 2026 01:23:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 40E5FDB4
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 01:23:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1E53D401E2
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 01:23:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gu0Yf1Es2tLZ for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 01:23:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3E558402DA
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=IgANqFJ+
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3E558402DA
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 01:23:41 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-843cf077f10so3337409a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 17:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794360220; x=1794965020;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z0C8X3fdiNB9JoRZglij55rB9c38iuFoWrAKqPA4b0c=;
 b=IgANqFJ+lNh60q29vOrmqQSngrfvg0u4QD8lU83lAOWwnEp+kYZs9h3qna+P42ysOy
 SMXZ+wWV4n8rzlsUvQ5QNjvZLxIj0KSV2MWUlQInj01YC1wCpS5oY80pwav2274KxiYk
 r5kAs9bMwtdQoGHe6HJqkYiWZP9QP8sEgBdWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794360220; x=1794965020;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z0C8X3fdiNB9JoRZglij55rB9c38iuFoWrAKqPA4b0c=;
 b=KFXxWq2s3MoiMoCjQojAaWadNVHgpUdpBvspZLPPSMBGLmvSDB+3T1FDPIyPfy0VJP
 bTompX5b1ESZgIogFDaOvrzZ/ht/3oxE5/TyhCqOCUU+8ulBpoPIpEwjWK2CLG68Bq+i
 CUfytzGQxjhmqFO0jKiYgURcTsvBGon5wdQ8fioKJHEm5YpY8fA6oslr4d3euNzQkxgO
 QyhFjFXWMPWFhEySM7RRRl7OUFPHd+Rc2f4RQVFMKs+0Z/FWALRpr+xB7A9zOfiCdhV+
 bOXNf+Jmj1izw6abYGRC1dF6WSNFf7S8eeCPVmnNdrNoNdH2fGorpdSh9R347J3cro2N
 ZxTg==
X-Gm-Message-State: APuU4Z/zUzSxEWFGeAXB3MbfBCJ9wImNhX6JBPKDkX7RxgHYZ3QRzzd7
 4O9kQ6NeZS+rwf10vRGiEUrqUoO22ecJ0j7ai+lz/wqgAmu2RdhzYuLzClnCbtjUGww=
X-Gm-Gg: AYBFou2TKCz5Q1Tm02Yoj4+iDtwt9QYt0+ZUUrOi2n7M6j8iv7dffH8epwuGuvjVuSw
 6KvJnDp9ZRYuZSfXuGyT7TjUjhb6+Mfweh+uedGEwPqO/udwyVHZHdeihI/QBStO3uUVr7z0BVU
 rOI2UAkQm/dNDqn5waAUcY+bCnuD2uKelRDdMRGpwTsGmXIv9FuuDs6Y2kefrvydeC8fbyLbLcS
 mUqs+fgCRZQkLas1tednOhLsYHFiVrYWU//7ZBTveZTnqWrvG3t/PAI6fLNPJk3duOtgN9EjTD3
 jto+3zyRgZhmcxe3NVK/gNN9m+NrAV35KGMSSE3BIYzspYt++MRoa3404G39LByTD77ePJQPLL3
 4V4QoXLB5ie8WLgZ59c2tEHf894Ik5Xjq3Z9aLqfiZfOmQFQnWut8jnNKG368Kujqrz8LumzwNk
 vh4uTPnsGbKvPKOLPEho1/DmAwsbS9elEBgpZqcDsgYb6JK64ibbkgSPqkNAjoyJaUq+jgGmEQI
 2Vv44HFk6cMdIrZpBhhv1qQ6KTqkaNLInOhkpHz9w4fqmKaecf/HY6E77o9/3x68HtSnh9uCPOg
 6pBPQx2qr/WcFhAbTaPlmWtXRRMbRsaBd/egg6QVcA6slFIy44B1fVupJfCs270K3DBydTmvioA
 WgSOi/TJxM7RxkorfO4TI7QYH51TyMrrQdkYlNYxs34FSGDjRh+n7PeQT0QbLsTNb2bGsy9W6GA
 9wIC3WOzJswhA+18kKeW1vNPZQMLcEP/i4YTm0On1lrCxnJ9V3k18=
X-Received: by 2002:a05:6830:3911:b0:855:4d49:10a3 with SMTP id
 46e09a7af769-860f29052d3mr751864a34.22.1794360220618; 
 Tue, 10 Nov 2026 17:23:40 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-860dcc005f2sm3128606a34.22.2026.11.10.17.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 17:23:40 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, neil.armstrong@linaro.org, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, Petr Vorel <petr.vorel@gmail.com>
In-Reply-To: <20261110192842.869a758d460c83ea@pwishid>
References: <20261110192842.869a758d460c83ea@pwishid>
Subject: Re: [PULL] Please pull qcom-main
Message-Id: <179436021947.336966.15615178353019464857.b4-ty@konsulko.com>
Date: Tue, 10 Nov 2026 19:23:39 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 10 Nov 2026 19:28:42 +0000, Casey Connolly wrote:

> A few fixes for 2027.01
> 
> * spmi: msm: Fix V5 ownership table offset
> * mach-snapdragon: skip serial# env set if already present
> * mach-snapdragon: fix the serial number taken from the command line
> * doc: board/qualcomm: Fix kconfig formatting
> 
> The following changes since commit 934995f642a21ca7f35fa9aed5f061394fcba243:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


