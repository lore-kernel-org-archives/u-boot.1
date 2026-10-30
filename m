Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BF6606A31D
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 09:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CunSgAm+;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=U2Q4EY1F
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AEEBF40A85;
	Fri, 30 Oct 2026 09:57:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tzfYMQEM9eWm; Fri, 30 Oct 2026 09:57:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ED79940AD4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793354258;
	b=qMSXlyKM5b3tUG6T8UwUJa4kSycxAdLkl/7qSKN9FHdfzbrkHiPN0GZMDw6doCb05+Gn
	 oWfvXdJO3U3pLQDEKJFM+dTeGmxLFFQz4HtQZJbGUy303NXe92uqmxhUcY5XjTpUl2zyu
	 0FJH+xn3uoIiebcFXX+F53bvg5SVOGE6StrDRYOjfYBGPu6OSu1pTQrdLycwNtVwBT1JG
	 Sf5y4YX8pq9ZgatNjtm7XXkZ1ZvX9V1DRfsAF4tWqGaTbYRc+TgdmVhbpsm4tDHUDLSei
	 Sggf/1ii/YrnwXa3nJA9kpGG4/aRxmQZR/07YS7PfSoSgeWBAbJHT6a01N6rBLEr0ew==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793354258;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Er7MYsBNr2CwUw+KcBcXaMqTTg3ERjH3KqcvQJ0TIgY=;
	b=lkp3aW7mWtI3XzE9S+ZUPP9zvbvHMlpzBWwDQ7XVsmrBZt50CsFTZf6DSOHu3kt0eFP5
	 k+JXVjvmt/sAW5YKyhjmTsc5B126UTTevJAAU6Vseta2S209M12ygGOj+g5NxYVX04NR8
	 Mhjzg0G/futWW9yjNzibCoAtFSfkGPj1lMoDaiGgOcEct52eIYRBcj0e03a43SY7FCz8B
	 0rCBmOALVJAadyMdVxv6qPctW5r7Cvkd9pz0LSb4D4gc8h/iyTVtlNhDvJCECqsEYV0Cx
	 lwVzLbxm9ZXJl30JKSZFVgs+1pMevtK4ISSW1dq4syCIIRyJ8agHc+h1P+P4iypiyzg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=U2Q4EY1F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793354258;
	bh=Er7MYsBNr2CwUw+KcBcXaMqTTg3ERjH3KqcvQJ0TIgY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CunSgAm+YKQM9vjbEttxtWz/E4evl9hoyKkBoYv2pJgTD3RmC3loxr7MQ+mFMV2dX
	 cO9bNdnHeG0PWSZ5ifthvdVc88s/GZow0wHQD1Nd0vUxBKdp4KOnYwCRztMeNkMNY5
	 2eekO88ot4KvX1rBRG888Qut17Mb6FctEpmKx7IiprLDtoEvbLLC/uyWwgW6ftVK2n
	 gfKqoIrpJaRVCIa6MNitgO3t+WDE2QBD5d+5fL7ivluVvkPxCkjQDcJo8VMEthqMl5
	 LFZI0Lw3GYoy6MUaZKfiPbfGk8sc7Wi2AjqGqf7ARQjFD/lF0/5DUPmEyOJRCT0461
	 IswtzsA81ObRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED79940AD4;
	Fri, 30 Oct 2026 09:57:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D38A4BC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:57:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2E64940AD4
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:57:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vm3x_UPyrEDB for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 09:57:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4136540A85
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793354255;
 b=qnUfp3dShvyDU3R8SXE3M+PN+0j4+Mgqv4DUjOToOMa9zu1IK6xxuaCh7Ayn5boDEnVL
 MdLJ722tFgzIS/nbiU0aBr42bmBsxd9XYeV+Jz1bsznzDr6R6eUKeNe6mr1Kzeiq7pJMq
 xGAzDZzd/X8/b4BoVg3xE5WUpfiB01hgr8bbQHpv6QJ162n4P/tdztswrA9EJNolqcAIH
 SLPRWVDUpNm/LUOD/V16NzLknYvqhL+fX64UFsqtXGWbEhLWFBWagjwiD0A/qCkKqq5Et
 NFkWrsI0xQrLwJD68v374z3NdUScAHGroQgwOBe9hP9tagSIfBlD9E/ZS5OYdh07f+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793354255;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=Er7MYsBNr2CwUw+KcBcXaMqTTg3ERjH3KqcvQJ0TIgY=;
 b=iO43AxZq4ZwGxpFd4/3ptuNv2GdsA9tqg0SAnFUQpqgFApPub3+x3lT74Dj+genZ8Kne
 8sQBekb9LF1evDMcna6R9wrlSuXkZ0tD7q+QN6o433fwW+z8Ug8uLwdp/b+ips3pawI0t
 hHDLHVnASyQyfB7WFO3MGGQrJtc0/82v6xOoAxHVHKSUUKLApRiGliHE9K3WeiybLXrG7
 HBFb1fsGmOiTMXsK9aKv/0E4M2CesH7eRNnDBLSeB5s0f+24UYRw3fk6jrOout0ygHrgL
 SSbf84dAFy+aypEbl1cdm4FQGRee+60ECJZezpAqVA5ZSI7fSIDJPRcx4oZdMqsvlPQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=U2Q4EY1F; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112f; helo=mail-yw1-x112f.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=U2Q4EY1F
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4136540A85
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:57:34 +0000 (UTC)
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8acda240937so4144257b3.3
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 02:57:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793354253; cv=none;
 d=google.com; s=arc-20260327;
 b=OQRN4iwU0QS2h1FitLFQT2E7w85vJqsdGOo0IuKJI0BYdEtsH6T6mjV4xPlQhP+yqi
 9LiUEGXUYobrlCc9/eZNwI4rgAG3rgGYJ1cLFOax8KlOmWw8xDLQ0oGxjfMF4iIiqywg
 WDAmOl1TgpEKCu8oLwxE0Qxt0eAroPTi0AAuMUOM6+8Muz/lAc0Lf39t0v9glAXbB4rf
 mMj8ucqumlJOfiV4WNJ1HDkbxrCxpEvSU4sxQuRuRaKIX9EcNGzReHKhq8r9jtrq71Uc
 0jpXO/QVVu5U7oAqVJwL33WH6TMFS+2XyylTs0xAKlHzb7dy9rKJ7dQg3oDMJA0CR7UV
 YvHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Er7MYsBNr2CwUw+KcBcXaMqTTg3ERjH3KqcvQJ0TIgY=;
 fh=7QWwyUnPAQm5WNln6yz2UnPVMLv30rqCuNC8nkM6bR0=;
 b=cFn+j3Bj0RPK//Ih0ZBr97UgckluAoRL/5lqen+ntQ9WPJkDdnMYe7TFqAQw84VJML
 JLTcdW85ms43fBB1Xgo4TUKWGLNjHDftCfvz3SDj4KxUMBoYrFBrQmjHYNKjFS9BnIn2
 NgqkFAbSrKfLRzHg6haf5QW5gai7/o7Sy1aDsR8Xi4gDG8MbjYQe/CAg63NXCTaOpAMd
 k3lfs9q1T9zEBNcJ8DW1+phtGqvSotZZT6P83CJRbH1Ga+vo7yFnDL0uTu9y1O7C8H5Q
 ufWDnJx0vWNsPkIso+kspTfq0wIaxtGEc+NHQBbVaFL/Jb80T/PRQ8b0JQAmETL4qdMW
 Gssg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793354253; x=1793959053;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Er7MYsBNr2CwUw+KcBcXaMqTTg3ERjH3KqcvQJ0TIgY=;
 b=U2Q4EY1FPbsCNYg2XGdft5ugAsTj3EOgptCeMNiIBdXeGXKfdLcgTZwWdsxDPK0j8L
 FF5yuGKWOgOsJws3F/7AoZi+I+eH1s98AvQqwgn4a3z62WTmPv3Hp8y45tU42QCLDVun
 k/cYmidp0t1xkiTir65T+E1ybE8e1FOgMiszieuhMo4VNcUnr8nl9y8q7g/3ICs4O/qV
 hsORRrcKBHfHc8+fAaEDkY1MZheVf6+q83KWLr6vEtMAX5DmRt9EBGlZkCO7VL081bTd
 +qG2sJNwmkwSSjK/9Yw46ZwTMcsNefWGaT0kP8AmYycnrlrxp93ollYy5vsbQWnUuRbf
 9EKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793354253; x=1793959053;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Er7MYsBNr2CwUw+KcBcXaMqTTg3ERjH3KqcvQJ0TIgY=;
 b=rjbJuOmJ/l7bK0TOeNPwgsTQVyGY1hmDpx35sOkyspnYrW7QwcRdcJKkCDt0O4CtVi
 i9R7UPM1oHtPy7ud0CfyEkc+RwTh/0WTMx7blUfsA0Xclr25w/R0gBz2Pw8AGXp0iYXb
 3Xn+rv5cPpY1Tnk/iG7Hax+BVVgp4+hy9csQXZ1eRNz3vF1WQ2CnKZ60un30B93+vc67
 r9anPYOTw16QGzOrws+FmrFBOivNaYWkMVTCwHdKEFfTfpSPqcmvR6Px9qb+vSeCm7te
 JASZWT7uqt05ns6KB/EExRJ3eNjWUwzfxYtmaBDTKz90ghVVzrcHOIe5NgpbG5mb1cMQ
 B3yw==
X-Gm-Message-State: AFq9FYJIJYpHQvErvS0zNlMf1iQje2zU95697eFx9NIc0fdQVGZAjsvC
 UN/jI6ci0V3J6/1rguEtSAjr5Qxg4wNL6ODhNAjyY8wkO0pMsBYUu9AHIs2TK7dZWseZA/8WDVL
 Stz8xrnMYOqJ4s5FbnLpPimCUy5b2PvoI+niNx6rgSQ==
X-Gm-Gg: AYBFou05Z95UyEOMHPnTU1XGg1yuGKMFGYatLTeSRuhdONZQ0uZ5pTzvg7oGt0egC1Q
 65yPW1fZ5TryhfUEaSFGS1LqDrIS0mJ7FdaodNvRDcEAnNoHkTkQN6en/1VvTE62Z+E9Q5r/ekm
 u1LzN6meGfJzWmo67JBUnHUWzwFSoCeumvLosyTTJdIQ5bIfPDboyq1IBMGQKalc08h2WKrsvgQ
 kdQE1PfiZfAgs5QNPM22727iRZgN5lfSHHRb+YHKEt/f5NAup3SRQPgAUedmw2QTjYIcRh5CGsd
 z5ig9I3/BWreAYjaysefqIsXc3IqwEIKGKCOu2TEdFI92LOHxwphaGulB1IVYM0LAfZReMtWpNx
 ITlzCAIdjBhsNJ/EWmyVudMNWxBf0uCljhOv+2wzHjn44sRIp4rpB0gl+6K6KsfUOGGwoqMphsQ
 u4T4jJx7g1iZ41qudyGVAIYfcPpOX7zh2nTVxXuF5fDhZoeIeQIV3/5KUkilnwvrvrEn+K31KCV
 JzOidTymD05zb9a1zlYTJAuCYmsGGnTq2v+lBlbiHVuc7DzL1k/c5qVc4z5T49ZzPErP9YATyQj
 EaIRJ5Xa9CGuka41dk/u8n2OKWPGHTPkFwsHID8mPPvw2xWSZsMG7lXSpe46RYgwWhNM/TR2pJ5
 xZ6IHVhP46D4ev24dksXuxoLwpvR1bv+7yR6xYMpixeW7C7mSzJb/vtAaqvTMNyoohgARZAqB1u
 Gmyr/G3kgJq7RWhfLWQkWqlcpYlWV64dwHdi0Cg4PIFudeIUay2zOF00+Q
X-Received: by 2002:a05:690c:e650:20b0:8b1:55ea:c6cf with SMTP id
 00721157ae682-8b2b676b569mr7317797b3.52.1793354253487; Fri, 30 Oct 2026
 02:57:33 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029150906.1558380-1-tkirchner@emlix.com>
 <20261029150906.1558380-3-tkirchner@emlix.com>
In-Reply-To: <20261029150906.1558380-3-tkirchner@emlix.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 30 Oct 2026 11:56:57 +0200
X-Gm-Features: AclHuK80zxi_gf4k2W4YMhyKmcll95b2eGLr21h1_RC5NA-GYHN6RX3VuooySwE
Message-ID: <CAC_iWjLtepzUbQp5TADU+KkGesyAwoBJyzBZPgpvnfhgDG-XDQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] tpm: allow TPMs with more banks than U-Boot knows
 algorithms for
To: Tycho Kirchner <tkirchner@emlix.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 29 Oct 2026 at 17:09, Tycho Kirchner <tkirchner@emlix.com> wrote:
>
> tpm2_get_pcr_info() rejects a TPM that implements more PCR banks than
> U-Boot has entries in hash_algo_list. A TPM with six banks, for
> instance, fails with
>
>   tpm2_get_pcr_info: too many pcrs: 6
>   Error: -90
>
> even if all banks with an algorithm unknown to U-Boot are inactive.
>
> Each bank corresponds to one hash algorithm, but only the *active*
> banks need to be supported for measured boot. This is already checked
> elsewhere: tpm2_check_active_banks() and tpm2_scan_masks() detect active
> unsupported banks and, with CONFIG_TPM_PCR_ALLOCATE, deactivate them.
> These checks are never reached, however, because tpm2_get_pcr_info()
> fails beforehand.

Yep that's a fossil from before dynamic PCR configuration.

>
> Only limit the number of banks to the size of the selection array
> (TPM2_NUM_PCR_BANKS), which is what the parsing code requires.

I think the fixes tag can be stripped, and I can do that during the
merge. My only concern is that this still won't work until the later
patches are applied.  But since it didn't work to begin with, I prefer
the smaller patches

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


>
> Fixes: 97707f12fdab ("tpm: Support boot measurements")
> Signed-off-by: Tycho Kirchner <tkirchner@emlix.com>
> ---
>  lib/tpm-v2.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index 137bbbd9593..43ca54621d8 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -702,10 +702,12 @@ int tpm2_get_pcr_info(struct udevice *dev, struct tpml_pcr_selection *pcrs)
>
>         pcrs->count = get_unaligned_be32(response);
>         /*
> -        * check against the supported algorithms in hash_algo_list,
> -        * instead of TPM2_NUM_PCR_BANKS
> +        * The TPM may implement banks with algorithms unknown to U-Boot.
> +        * Only the active ones must be supported, which is checked by
> +        * tpm2_check_active_banks() and tpm2_scan_masks(), so accept up to
> +        * TPM2_NUM_PCR_BANKS here.
>          */
> -       if (pcrs->count > ARRAY_SIZE(hash_algo_list) || pcrs->count < 1) {
> +       if (pcrs->count > ARRAY_SIZE(pcrs->selection) || pcrs->count < 1) {
>                 printf("%s: too many pcrs: %u\n", __func__, pcrs->count);
>                 return -EMSGSIZE;
>         }
> --
> 2.47.3
>
