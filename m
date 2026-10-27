Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710AD606A325
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gos8/XA9;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=SZOz0IEy
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C131B606D7;
	Tue, 27 Oct 2026 17:33:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id es-IUwmifwwL; Tue, 27 Oct 2026 17:33:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C532C6068F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793122433;
	b=ZK18FrnZWDzfYHfgIXOLTaccW2iwkAH9vYPB8oxfcN2N+RH22V/xPQ0bJYQQlgoXnPOY
	 +Tb9tAx/wJIkBHouEvXsXj8kc4jbwMim7ut/TyF3zfgYxeWtKRVbIKJ4G2AF5eie+8s5T
	 Kc+tDoLHW0rYYsjLNzte19dgNpKd+7enEN1UF66fW9lj7fJJzERkIRj0lg4Ec9Av30bCz
	 f+gWYoN4vo0eJYyqAOYEA1dJTmHKiODlhZKirQPY6V3vYn6r2Wos5VcDaZwe0srWjWXG0
	 Wi5AvmcjMC3ZksGRMG/H30TXUbpArkvslwoC8ZN1umynHvfgxSn/FgLvbbNrNM/DWOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793122433;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=uCGfT8HgVCe7XUpJd0r71m9JNu57abS/RKqbn104A3A=;
	b=SNn/v8xsx6aqrd+rGui1ZO6w1qyaheZsZHcMI67/HC+ktmJ0bcQVX3M3FQSryObmZUC7
	 +H4vpPrYrbZ3NQt//NAXihO6yZxxmsSkoU9TVUw2ZDOrRPVT5orveY6ejnUCp+tX2uAzZ
	 x7Yr3+CQtKOzySlij8ruW3CQ3R6Rbo7e9ZjT/iQZiCXCXdqTaDres2gethnMVJm4wNjZn
	 x0m/quJNbDxyp9gU6L+m1dwNb6/EwtEhYABuuK0N1TZ4fLkrKZJzUijzLc1UZlFd4IONp
	 mGdjOtQWwfT4jqTCmx5CcWj4LuocbZgtuxNC0hB8W9rbqmRn9TN1qy3otrf0J0QNsqA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793122433;
	bh=uCGfT8HgVCe7XUpJd0r71m9JNu57abS/RKqbn104A3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gos8/XA9PfzMTR/IhNHpBucQp0aG6jlq85VcnoqPJ6HwmDxqRwhujqZGo+A7XSzOb
	 y2BdHUWZvdZPfZLErXHh8ty5jkJnnxOG5VYKH8e2KvLJrZl5jGD19c8wb2MTBPXOg/
	 b1TYmz0YwvrE+TyUBZzFiD/tQv1IK9byXa1Vi4mU6v3VJTX53Y9ByXZIBwQ8YFTzv4
	 lfXlKxx2OuBBtur+cjPbvsYOHpRBFIDhHwK6DRlS5yaTSik1VkjvIFGS9GhG51B7kl
	 byqBpNJdNzN0zCfGfWMKPl1ayQ4Ll69bXUb5MoSYuVi0RAnk6M9fsVejG5CFqJ2Vqx
	 BTqr993TLrjWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C532C6068F;
	Tue, 27 Oct 2026 17:33:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 30507529
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:33:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 163A54055A
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:33:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jp-EVwzxZ_Os for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 17:33:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 069BD403C4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::5"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793122432;
 b=Lc9rQr5OFOdl0/LlRJp/e96T8FkWGimYKseiKTTnoqTGNmG9b6gXbPymHStTIiesPaw6
 MZqTsYmhFNgFNb5KKWpZ3ApTemOJD52fUvtt1y+SHkPpkNbm/vWXpkq2uhs5rA+p4EzBm
 ykHo2CGHSlK/Tk04xG2Qkvxp68lkrTDtSM7mfLOmtGn8S5XrHK0D9uo6p8kTR8YtqxpJ+
 fAI5OwJbqZLFEZoLQtFkqbZbIffOMrEi62YVkUel9twyzzIPfbp86fix9zBxUVVZVUViK
 dTWUcO8Qgqw9guBdEgwR7leK8WCv84SFnaOgjdcqs0u+8TS2odmhwQCB0Xyle0SrvyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793122432;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=uCGfT8HgVCe7XUpJd0r71m9JNu57abS/RKqbn104A3A=;
 b=NSt/4DjWsjQZbrma/1Rxm9hA+nwI7SFLcu9Lihzmu1Ahwwyl6jmkcj5nKC1mo7YmSsFt
 g+gcut4x0S7jTPM1uAJUEFJ5PC84msHS7icMa2hELG9lPLrS5uuhmTHw+30b35vqkdgq2
 2LNfCi0+dLuZYM/DKtL67ozaGXo87ziZs1HH2DI4Z3/XYsqyLPiXbpJtPl+aJxK2xSn8G
 69UuFO+gc1ueyz91+lYsMPOUZy2ySwNHHFptejSpXMypdNYPb2F85NU9ia+vWXS5qqgUr
 bg9ekjvIx9TQBaJXlpQxF6j19cwA0nulizldsRqX3ngAclMkaS7vI3spBalg1ec1WCw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=SZOz0IEy; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::5"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::5;
 helo=mail-oo2-x05.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=SZOz0IEy
Received: from mail-oo2-x05.google.com (mail-oo2-x05.google.com
 [IPv6:2607:f8b0:4864:31::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 069BD403C4
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:33:51 +0000 (UTC)
Received: by mail-oo2-x05.google.com with SMTP id
 46e09a7af769-8458555b6a8so18276a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793122430; x=1793727230;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uCGfT8HgVCe7XUpJd0r71m9JNu57abS/RKqbn104A3A=;
 b=SZOz0IEyf01hve9tUPrEw2t64c+IGwcgrvXBDduJdPELd6obMEQ7pdhjQb24A25F1S
 x3rcmCb7Z4nyXj7nT533fZZxkGs2Iz26kDy1z6xtgAchNMtftl1TJO1TgZm/1TSEd5sZ
 WM9o648Tby2gXlmC5hYFtSsgYM2KmUIy4GhAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793122430; x=1793727230;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uCGfT8HgVCe7XUpJd0r71m9JNu57abS/RKqbn104A3A=;
 b=KOCu8Ybf8k6iE37sTR+vZwlcWFbDq3RzSgx5wKyd2YZXMNamF9GubbF0JW81ElNEZt
 yrUk7kQ5senOZDMFuij/N2xb0AnvNmTNpHWw4TnEB3ew7tWKcAJJY1dB+d0YgXV/+iR9
 nyovMn64rESc25bU42pP18VqPYOodxTAHcVa+QZFUCEvQq7FJ0fnPaCBVhXn4i82MoId
 4IwEhEuurKuWwNGuChNtx4Ju7xX/rlD7WXOF0xlLVnEPrxqubDxjId5Fdj8SOZXYA6zT
 Wrzu8DmLPYXQbzEzT0enSY75UVdEL0wVfV5tbZMbGn1rF3gpE9FJkNiBt8QgFmMEsX9p
 LhpA==
X-Gm-Message-State: AFq9FYJhHTHEvkCs3sW9dZ2ZjGLwpYV0/h+Ml+USflT2QM3L/Obz0RW2
 yv/Kss+REMHj4Cmxa46LnMB3yVYu26ksnAk51qQ2cDVGsAG0/mk8KiKlVDhy/uOc5h8=
X-Gm-Gg: AYBFou3VD0D3wlV93cRjk3rycHPDpFGBjOw5KajqD/RtP/GyphX/89V7B5CzCDc/f1Y
 cANx9Z2j846bhRbRBYmU8JbXQYYEsWwVVugxEswt89FBfQsPh6OWnZEXXfptcw5LFHcDt5SBKYn
 AMia1AKTDjEAo8r22VVkjBUh1vVSc3umQhhawOLU5jOgAxsGDSAEngY0agfBhYKbrJpnoHrYwBu
 POl+/waDXSitqeCapFJV7B/CdGe6i7VEcfsjBW4kH1WXua+7CpeukO1DrvsZ4Ih6RxVyYTzeofx
 x8Bd1ptcSLokIIsit4dh+UJbnMQwsAHeq92nGk9xflugneKnFLJ+jdzmIQkZkiZcXFpxYArOLBx
 C5jSy0AiS1yRLUFzzCvqSXA9ruBh0leorp0IYJXjuTfFbHtrWoiALwZHAoQFaYL2HQ1e9XIKKUA
 xW1Mmuibij8hX3b+M0tMNpG40WqoLxGRUEku6J39cXGOY07KOf41Ts7aN+ramm3YF8Ixc+n50uc
 aMCVN86aTox80q7sAK0/LMmP5YK+Y1uP8YiVHkFlk4+BaoWhqTVP6cG8TwULFWwjGJqZFLp7La+
 +fTug6O7oRUZJKOa7lbiiQ7R5s9vIw6vRzeKlfXg0hXUU2u5FRj32ccBWTcUS5FIjVnKQdU2l9+
 7iMcVYpfzHFj55C9tPQU4jFuvv/1pCTFlriKmI/qfWu7f7XLLu5DocNRTBA==
X-Received: by 2002:a05:6830:90f:b0:819:28cc:637f with SMTP id
 46e09a7af769-85aba1357e7mr206116a34.0.1793122430569; 
 Tue, 27 Oct 2026 10:33:50 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fa99c4f2sm11151640a34.6.2026.10.27.10.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 10:33:50 -0700 (PDT)
Date: Tue, 27 Oct 2026 11:33:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 James Hilliard <james.hilliard1@gmail.com>, nd <nd@arm.com>
Subject: Re: [PATCH] test: Add helpers to preserve console silence state
Message-ID: <20261027173348.GG2177077@bill-the-cat>
References: <93e4e89a-6c3c-4a3b-aa90-bd9090a6daaf@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RGy/iL+Ppv0PDG9h"
Content-Disposition: inline
In-Reply-To: <93e4e89a-6c3c-4a3b-aa90-bd9090a6daaf@arm.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--RGy/iL+Ppv0PDG9h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 05:02:12PM +0100, Jerome Forissier wrote:

> Some tests intentionally trigger diagnostics that the Python console
> parser treats as unexpected errors.
>=20
> Add helpers that silence these diagnostics while preserving the previous
> console state, allowing tests to hide expected errors without accessing
> global data directly.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@arm.com>
> ---
>  include/test/ut.h | 17 +++++++++++++++++
>  test/ut.c         | 15 +++++++++++++++
>  2 files changed, 32 insertions(+)
>=20
> I am proposing this patch as a prerequisite to merging the series "net:
> lwip: restore TFTP client and command parity" by James H. [1] which would
> otherwise introduce a CI error [2]. The error is fixed in pipeline 1762
> [3].
>=20
> [1] https://lore.kernel.org/u-boot/20261024-submit-lwip-tftp-combined-v1-=
v2-0-0f663f735ee8@gmail.com/
> [2] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/jobs/12=
8187#L3716
> [3] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/pipelin=
es/1762

Sorry, what's the unexpected error line(s) in 2?

--=20
Tom

--RGy/iL+Ppv0PDG9h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauDgeAAKCRAr4qD1Cr/k
CkFjAP9RFqpxZpnT5vBcd7T+nxQbpF4fP3vuMUqWCahcrD+AJgD+IntJEy4NKd0k
xasYdTcbeG0sOngI4R+8UUilXRpsvAQ=
=KNFR
-----END PGP SIGNATURE-----

--RGy/iL+Ppv0PDG9h--
