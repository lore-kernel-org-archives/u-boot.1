Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03994606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OeQQWZ4m;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=eCng14C8
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D05AA60611;
	Tue,  3 Nov 2026 14:43:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 96MPuRVJN5xJ; Tue,  3 Nov 2026 14:43:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F2271606A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793717013;
	b=UqZEEn03QXsmyVJiP19cB0DMSTWq7wUHbvm8Pnw2b8+vuEjNuiBYn0+tjlX9Mo+F5kFs
	 gA3BBnXu0SfwJ9/XnQCORZwYb4xXbmiswx64RxNRpzwYRezL3d9JFxRt5RzmZRUKu6mYy
	 L5R0IwCZav5bY3ujMooj68R9I+4ni+IatUBpX7KvyqxSzl247o4GSEzgSB3jAW7GvQa/X
	 davul26Q0MdgvjbpXZ/o0yw3WnAhU49GRG2oUEYRpjGtYIWUKbdD++b9gusVLrHsQokgE
	 oZzFNmB3WGxJSoTpuZyqzvQIdrmmA1B5+8he/nu039CraCKGMWs3NZ0ZVkK+pBfNDHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793717013;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bNbo1DT9t+Pd6c5YAG1A+yyzg78imjhvF+X9gxEYLwU=;
	b=IIcPTHNAl9fRd4EEScPbiQg7Lry3xmuiWa19D4iqO8QDViLbj6PsFHZZo49Nc5AKZbNN
	 eJVKG+OeKWfVUnu9Yc+3sakTModvKOqEG65TNv/aUOFfsmR+7dJi0Fxvejzrmdulietaw
	 CAu0hPJYw4J8Mu0JaSuGb0VceXJ6rz/mCNkEWwEvkeUL+t4zqCD93tEui+udsNmm7FrRv
	 ddc0U9Wfv5IcfcD2u+xtFvCRXyF+JjdO5gbp+rdYT68wGRIMADq6El3MM+Zh/tIMkpUUd
	 3GPJqEw8KK8Y+whK5dxHOwa8o2mQ224RDqJ2z8BpGJX2/cMNDEhUUN/gf4WSoGwA/Aw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=eCng14C8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793717013;
	bh=bNbo1DT9t+Pd6c5YAG1A+yyzg78imjhvF+X9gxEYLwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OeQQWZ4mhfwv/AlxqNfKZY8pjzdGIjSj8TASJvb7YR4/6M68OhWNLhUdrR048FOcW
	 Qo2OXNkKjaAmlFg1TY4r9n0XSbVOtmQx1/ZtPtcWvq2IZZDyZrlIUgXcDFjpRYoqgA
	 jZp6Y7D6BnCFHAk78/Ipqw9vuxDi0rhz3loUNLx9ZjyhVuhDr0kYqhxZRfiiZDbz0/
	 NwjhX2tlOngjYRQ0OiFFI6SL3dF3rwgwC1vGacDVoxHyzRl5wpbHzuyKPe+wFusZe8
	 iFtoyx09teYH5Sphv41rRmlcFAsV57XQy1SaTbVackGdPSURIuNrRfn2MWU9+ruqhJ
	 dz7/IYNFjfj3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2271606A0;
	Tue,  3 Nov 2026 14:43:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 06AF9D3A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:43:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EC7A5606A0
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:43:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k6MCL3DlEszG for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 14:43:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1FD9360611
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793717010;
 b=JsX9utYxfYwu9sYQck4g1oPwUwmqlL2d2Aa8T6GMNT/yI2CYoK4Y+Jo6EQglR/WUp4SL
 EAdzmWHZjI/miHqTOsnRrTWnD854RAa2+U5NQh5tuLm0nRVEQNGtJ/4z1v+tyUQyavThx
 yHb5Qek15yxF+pNUG7HTHYxa95FpC75Cm1FmNCE2/rGvHiPB4kRNJs4A06w8LaUuZ2eUS
 VwXJ8UcE9Yuw0aZeICtR6B2CnIHXgmsehA6F87Ri9PdHtYLUfVuGaS3aumg8s1kcNHwhh
 VW5wHT2TcCcb08EwChInPtZcOWnZSGjMq+tmUe+VlxShQthG0wpsw6KXAzgU8t91pKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793717010;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=bNbo1DT9t+Pd6c5YAG1A+yyzg78imjhvF+X9gxEYLwU=;
 b=QC5ToBQ1E5WJbPd4S4ZCA0530W0qALvVZG4LOxnEcvGd4olStSlS8zYYi33YW3N63Cr4
 WHSOpP3GtiwK1qOV1bKyGn8Im5XmGodAdIj6ez7p+UP9GFheby0RqcJUvrI+O4uOBF+/X
 CyBqIvnWqgeUdB29blElmJcnxNW42henXOInmA/nfneAPmusbMlC+1rOnK4B44bidFPxp
 0CBfwaKHHcIuAjYCyU32WR0kLvEP+Fj7krSaBl/KiEnr8rOj9a+e15iCluRmp8rKh/5/M
 hg1pmT1PkHEmUHn9thUtMmz4bcdUHG5y27VoiL7poFo5tV7vJYQFymNgemND7zHIWNw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=eCng14C8; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=eCng14C8
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1FD9360611
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:43:29 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-706113e92f9so2352085eaf.2
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 06:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793717008; x=1794321808;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bNbo1DT9t+Pd6c5YAG1A+yyzg78imjhvF+X9gxEYLwU=;
 b=eCng14C8TfrzpvzEzKZpI5haV52BSOMqtpM1iB8jNndq79hEfTVYk0jF9EWBUf1ZeW
 MSN19xGdSogWWctxZLGDnpWbOo1IsqlvA0mzwo6ihncIhgX5+hWFncrXDENw3O9NBW4e
 OryGJLSHkkelDK+vPiYXIDV/PguPkOrqlNBYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793717008; x=1794321808;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bNbo1DT9t+Pd6c5YAG1A+yyzg78imjhvF+X9gxEYLwU=;
 b=QwG6okIArBVyIyZzrKs7drog8VCWcWa1hZ0y3upPQtPl9WhKEryjDJaNVugWfbns4G
 IAYL96FWnxQHCAY8YcspusA6dhJE7mdUPe5yVGjvLneqsZea+6CLQg1SwPuXGYPPa/dt
 e9NgzVTMapmwBsBBqR90nSO6xDDlWXqXMeT720BfUzC1I9tovMSiHd8PV2I+HSnOvaUq
 krllmu1DgEFBNtR3XFC3CGkhpU2bQTftFj2PNxCsKY4qHFfNRjgnbEC1AX2skMPgG6Rj
 7YWIAbXja6PttJ3ChKw50CpGWbEncJZGA5OzB1WbnomSnZgUtF6ia/tAwGuz3Z4XWkdR
 Fy/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxM2hmVIGZEVo6rPTdrvSektI34pxCATBKW+ypqg//DcJbnGItO2mtGebKZgZRb/Bs3tliQ3RU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8qMHPK602g2dfPjkmvgNuCQhSYP1FL9LLZXufm/92a1c/onh5e
 OMEzKVTCpNC+rQa/7Yhg0wHrftaLOoVmDvQhG39rVm3Q5bvsOO7lcXmULHHS78m4y6Q=
X-Gm-Gg: AYBFou1Lik156ET/eK1NjXrlJkNOlrKXokCbh0K1Q5y+zgiV4EH4NAkbZVXsy9uTNQj
 Y/vyDt0C9lzqyszBjdQdPRMY7KEKaLUANfNEWlG0BXNCFpO8rqV+4hTdsMMbVmW1KD4/Fd1Qx5s
 pZ0X1xdrlcdpxHqbpX7VdfLJhBc1XA3fafYRkxh6qYlc7NgM1IUlA6ybzH7orFfzuZpi8oZnk6y
 onKm0E8xgJ15Qa+MnHhtW+qOQgONXYMGCcvmLrvpMjoskMqNgh77odXngUgngrtyLnhEEqqZQrH
 +NddN9Qft5sptmqBsrLtY1a/K0qHGF70g7g+Ig2NvtotxTjFnaDcrfBXd9i9leVJcuQgn4cWmdV
 nQm2na+qvLMsxaMP3FyY/N7ar12kKvA7rLeAhyrJDc8QpBrA3wYAXr9dqvMbWsoxQwF5E0UkejB
 ZfDky4T+v1Fq1H9znLvR9JteQ1b0dwXGbVZ89CGkQmKnljohJFbiZmnja/EUDdOJwPKaczIRDqA
 R6HejsXWLRDibU9PAWthrz8YtYfb2BZruTeuh3mYcxDqKzQUomzWjdWqdxHQEk6sSbdu2Al+sYY
 Vq0fiO+4khsedJ4MSIajUQYMxd+S4whT1Z7Z4/uo4GjKSRZtEDdbUvB33xeEWOzi4+IS+DDz9zc
 NV7XL3VwPOEPfEVxgPSB0r3RymLxTgSysxEyprWno0HGZsJxJmyw2B2ioNdRTB15NhIm/x3Qvmz
 Rdhl+BWytk/DBospyQcuL/E1LceSFAdJo=
X-Received: by 2002:a05:6820:c3ca:b0:6dd:3534:478f with SMTP id
 006d021491bc7-714f29fa946mr4365679eaf.73.1793717008359; 
 Tue, 03 Nov 2026 06:43:28 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a9218ef39csm8780395fac.6.2026.11.03.06.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 06:43:27 -0800 (PST)
Date: Tue, 3 Nov 2026 08:43:25 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>
Subject: Re: [PATCH 3/7] spl: atf: optionally pass the bloblist to BL33
Message-ID: <20261103144325.GL3309461@bill-the-cat>
References: <20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com>
 <20261023-mtk-genio-720-spl-v1-3-f2c0ee094fd0@baylibre.com>
 <20261026154825.GB646438@bill-the-cat>
 <fc38ac09-7f0a-4301-b78f-954dff0b475c@baylibre.com>
 <20261102225159.GK3309461@bill-the-cat>
 <d92d544d-bb7f-4fe8-a5ad-5598643fb6ff@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iLynxgk46Ayq/SKZ"
Content-Disposition: inline
In-Reply-To: <d92d544d-bb7f-4fe8-a5ad-5598643fb6ff@baylibre.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--iLynxgk46Ayq/SKZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2026 at 08:30:43AM -0600, David Lechner wrote:
> On 11/2/26 4:51 PM, Tom Rini wrote:
> > On Mon, Nov 02, 2026 at 04:28:55PM -0600, David Lechner wrote:
> >> On 10/26/26 10:48 AM, Tom Rini wrote:
> >>> On Fri, Oct 23, 2026 at 07:09:09PM -0500, David Lechner wrote:
> >>>
> >>>> Add SPL_ATF_BL33_BLOBLIST to pass the bloblist of SPL to BL33 with t=
he
> >>>> register convention of the Firmware Handoff specification, through t=
he
> >>>> BL33 entry point arguments that SPL gives to BL31. Without it, BL33
> >>>> still gets the primary CPU MPID in x0.
> >>>>
> >>>> U-Boot proper already looks for a bloblist in its boot registers, but
> >>>> when SPL starts it through BL31, the only other way for it to find t=
he
> >>>> bloblist is a fixed address in memory. Memory at a fixed address can
> >>>> still hold a bloblist from an earlier boot, for example after a warm
> >>>> reset, when an earlier stage did not write a new one. Passing it in
> >>>> registers ties it to the current boot.
> >>>>
> >>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >>>> ---
> >>>>  common/spl/Kconfig   | 13 +++++++++++++
> >>>>  common/spl/spl_atf.c | 29 +++++++++++++++++++++++++----
> >>>>  2 files changed, 38 insertions(+), 4 deletions(-)
> >>>
> >>> Why are the existing BLOBLIST and HANDOFF options not enough? I mean
> >>> that genuinely because it might be the case we didn't end up plumbing=
 in
> >>> something here, for the not fixed address case. But I would be expect=
ing
> >>> something like SPL_HANDOFF being added and maybe touching some more
> >>> common code path too.
> >>>
> >>
> >> HANDOFF would need quite a bit more work, from what I can tell.
> >>
> >> We are passing two kinds of information, the DRAM size and some reserv=
ed
> >> regions. struct spl_handoff has a field for the RAM size, but neither
> >> struct spl_handoff nor the ARM struct arch_spl_handoff has anything for
> >> reserved regions.
> >>
> >> Also, the same info reaches U-Boot proper either through SPL (when a D=
DR
> >> loader starts SPL) or directly from TF-A BL2 (no SPL), so it seemed
> >> simpler to keep it in the same form for both. HANDOFF is only meant for
> >> U-Boot to U-Boot. To use it, we would either have to teach the non-U-B=
oot
> >> BL2 about U-Boot's struct and keep it in sync. Or we would have to have
> >> add more code in U-Boot proper to apply the same info a second way so =
it
> >> could handle either case.
> >>
> >> Instead, we chose to hand off the same bloblist containing a devicetree
> >> overlay everywhere, since there is already code to apply overlays, so
> >> everything just works without much effort.
> >>
> >> Also, HANDOFF currently requires BLOBLIST_FIXED, which means all of the
> >> parts of the firmware have to agree on the same fixed address. To avoid
> >> that, we would need a new option and the plumbing you mentioned, i.e.
> >> passing the bloblist in registers from the default jump_to_image() as =
well
> >> as the TF-A path from this patch.
> >>
> >> So I could replace SPL_ATF_BL33_BLOBLIST with a more generic option and
> >> implement the jump_to_image() part, but it would have no users current=
ly.
> >=20
> > It has been a while since I had to last dig all the details out about
> > what bloblist was implemented vs what was intended. A thing that I think
> > might have been either not implemented, or perhaps conflated / tied with
> > HANDOFF was passing the bloblist from SPL to U-Boot, and not relying on
> > BLOBLIST_FIXED but instead doing the normal register setting convention.
> > And that's what I'm getting at, it should be generic to have SPL pass
> > along a bloblist in the normal expected fashion. The path on your
>=20
> The normal expected fashion being, e.g. via x0 register on arm64?

Yes, and similar to xferlist_from_boot_arg it should be weak in
common/bloblist.c and real in arch/arm/lib/xferlist.c so that when x86
or riscv go and support this too, it's clear enough where it's supposed
to go.

> > platform is:
> > Something -> SPL -> BL33 .... -> U-Boot
> > Yes?
> >=20
> Something (DDR loader) -> SPL (U-Boot) -> BL31 (TF-A) -> BL32 (OP-TEE)
>                                                       -> BL33 (U-Boot)

OK, thanks, I get the BLxx numbers confused. Yes, this is some of the
expected generic bloblist / transfer list / whatever it's called now
functionality we didn't get implemented yet as fixed address was good
enough for proof of concept.

--=20
Tom

--iLynxgk46Ayq/SKZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaunzCQAKCRAr4qD1Cr/k
Ci3DAQDDygPChm2c363RXN1tAyYRCaLo13677p8HSh1q5IFwfAD9GnutsR829+m8
ZxJYfZCbob1xCV658EZxuql42Ee0owQ=
=KiNj
-----END PGP SIGNATURE-----

--iLynxgk46Ayq/SKZ--
