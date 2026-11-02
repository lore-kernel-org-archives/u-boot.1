Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41AD606A32D
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 22:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=C+/Y2Hak;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=rOvY77LP
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E40540513;
	Mon,  2 Nov 2026 22:52:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fjnrpb7WzKqg; Mon,  2 Nov 2026 22:52:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A47EA40514
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793659927;
	b=SmQ3cVwA+1w8aTJNP5S3tUsMudM352Sc3ZXmVdXVxf/oec8a2dYDWlxqexZS3AIUh9tJ
	 /Vy6WbKsj4rWPGxR1nFl7yTt4W+n2sgxH4ixNQJgkB12qQC9PNWLFwEyvjunZrZ4QLTRy
	 E6+wpPSfuTUmC16XVe0YeNBB2E+eXUOkcSfjXkAxIcVc6DKGD0x0N82SrL8joC5SIZk+n
	 CwAjGDEpDyQ+5XSk751NJmLugISTFmU2Mvy3pI73xQRzBZgLW84rNt+2EjuEOwrg1t9rP
	 Ptek12eS/Xs5thX1uZkNHwXi39f81KhzDsncDcdFNOvllPxeVqtGM4BcJBp6uAbwCCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793659927;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VEB6q34YAVxIQOqmwgzgKNuVZFSIl0bibHFGliTHbnU=;
	b=B8I5CuybhS6LgKJTnPkx1c8EQCg2o5wXvq70ga3I1RunZn7uPwGZrv8dTvp79c5FW3Bb
	 TAXHRjqJvITazYo9cCy+Xf/mkgCnB34LoDSdAG5RkSuxVI9PObNgj+wBmI06ageYxoKDN
	 l2dNnw99Dj4RtXjm/sDhh5qC95UFYIqXq2sY+LKZ2+GnZi10s7KjV+Oaw3pkigYhKf0SV
	 ViZpp/vZFt/rEQmEX4K7G03pWoAdUxKKBw/2m4gb02hGo4mANZg5ut2u/NRhfCjjQWsC1
	 hQtP2wPDw6W1px46cV2UUYhheiNp90q7f5kJ15lwMOjwhcL91+s8wE6wKlu1sHntgzA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793659927;
	bh=VEB6q34YAVxIQOqmwgzgKNuVZFSIl0bibHFGliTHbnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C+/Y2HakRzf+ZjCRnM7H17pCSiTz+aB2a8na904A0giwc3rMFOZIlj4ncyax6Nyap
	 3R9DaKkyRk66LfZ9pQsh2yx14aSSLzkynnJKFHL2j9KKWqffGfk5YoMEJ7SjWYaIgq
	 JoojmF8+Ax6fSpjNwUR3eLxFrGVXzgHhJA6xub/3ahLq9xw6AleJobAtLGstwlBi5F
	 sHyYewi7bwCzsIVLiWlvXfhePKjuw7bZEgLSZLQDM240K+dMbIERVWAlHFTqr/v3JG
	 2CjGve4wHx1Yrql3EPulBHDCAFoFFYeKvochbeb1gPMerqeGBeuICOJbG4fkTuY5AT
	 Y4xvIRB0tT8xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A47EA40514;
	Mon,  2 Nov 2026 22:52:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B7D55411
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 22:52:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9D633605F8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 22:52:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vKoigPtvoXRZ for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 22:52:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CC43F605B7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::35"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793659925;
 b=QT0Tr8wqQKCFOIINbkvmZAZaehEdgWa+7/9Iwbu72EmYCY1KaeJiekelLV9GdAc7x1fW
 4OWn1NH61yfbXeYs47tTTPqhElouwRO5lp/DuYjie8cu2UJoB978f50pLChVT8zTZ9PsK
 nqv3c8ZYTDndregX8vH5//j5nEQfB7d8aa0qqLrO9lLnXVohDz+++RxtyVYvakepEVa1A
 4xD66MGS+lhb5X6IxsuS4mq/ke8ym9ANP6FnWUlTXmvRo4ohEcVIy2FRz8pGaVuuZKMDl
 d/DsHEf7dxU4lAdkWDu0q300tQ52WPEHcAJ3jMD+0yO/0H2wTBHaPdLDWXD6vqkb1yw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793659925;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=VEB6q34YAVxIQOqmwgzgKNuVZFSIl0bibHFGliTHbnU=;
 b=fwcuDtwZQQMeTPn79nwgewiD9oglr0yjUo1y4khyHEDgs9v5/ChhzXjtbofIFiYR84gY
 +kuXh40DsOdnulbS7i3v1ziJuW/5tbGgdgc8WtpdaypPtTag9X32wVxm+YV3LYD3eumWl
 v5qINu8Xochy17s7oHz/vYsugmwGsqDdggC2qLdnv7RuZe6L01FjwrHjLXWJsEQm5crzl
 l3+rFV277cvdG37X4V3ZyGMLtlG3udRfsCnXzlMOLZPhFbzHs/+gVnteFuSei5kcBWVXr
 HvT2vfb3IO2zVvdxCp2Tpg30fEaee0u9roFsbIk+TMV4LbDBSKEcJuySAn75w64oMVw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=rOvY77LP; 
 arc=none smtp.remote-ip="2001:4860:4864:20::35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::35; helo=mail-oa1-x35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=rOvY77LP
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CC43F605B7
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 22:52:04 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-4a6fb4040cfso1122200fac.3
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 14:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793659923; x=1794264723;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VEB6q34YAVxIQOqmwgzgKNuVZFSIl0bibHFGliTHbnU=;
 b=rOvY77LP+UGCnlWPtDBx/CWlinSjmk9KZ53knqzI7vDOxRxhEaTa3At9NSsZ5zce70
 8GRNGs24zXSsYrcUbEo/CkZDdKXDraRkuY9Hhx/CwlRW9EH+XkB/54orKrDZ5+oLXc9k
 zas3Yz5ZgYGUqhMB/FTo/MQ1t94wSXRDFS7fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793659923; x=1794264723;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VEB6q34YAVxIQOqmwgzgKNuVZFSIl0bibHFGliTHbnU=;
 b=zYEeG3AkcVntxJ4Pd86JtWwlCZmA68tj/dqvOPNg86B3qJZ2jbU42/u3mF3aTBCdJl
 llUWXN1h4BxLrE9i0Zzv5qxuWdxqR3OKRjTsTO7uCKrFhXfs8oahQqrWSj8gd6VfWW64
 jj4glP3yaRFI190VECWu7z1rKTREq0FG92o+QAfFehq10s9GBep+yCMuP1lfgjYBq+MZ
 qLYUqHfCt5CO/0o79DrIzxWXzkHWHQKuXI+8aXWZ0Pw5ezptZ1mmD6o6YqWARfcgDZm6
 xU2iEnU/sSnfgbpZ8+ZsUAa+CA1dsqTk6pmIpfp7Jahjt4Fyfww3cPbYRin5OkmAp0lR
 E4Vw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkY7tfbH+vbQ/MmR1+GnXEHaOl/QPRRhbGxtPwxqVEwqmgf0+RBXvXnsHHY+1YKTg5gbtX5ow=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+/VmWhR2Cp9sH2XCmyGdgFlo8FlO+jBMwlFc2RnZpZ+y6vzITu
 ursCNiAG/uRIPUcdbEaDpxnOlKTYn/ByVmazlpc3iKFs4YvecPkSLI7zCq/dpUWfdys=
X-Gm-Gg: AYBFou02NlFdPuLMu3/KrvPFcg1mp2khfMSwYPgPWVftYrE2TjFgH8Wrcgex6ECL3g6
 Purjq81rJIzERmoagWYSaW04P8jxj7hVWi7futDXPz2ezIxmXJhqo7+K2C6ATFeGRTuINoLW3Gp
 9iVNRmVlpz461xnr+BPm8KOBTsG/Qt9ypFF6Or74BNfVVj5QCA5w45VLPFDZw6O+ctw0LyCvPYA
 M6bz+V0hhy9eAxqC2t2ODV1kJPae/jYFDqUikRa3xxagkaeI9KEGDv2dXLKB5ml2W4QeUVM0kME
 s4RKziOZOi2NNDpuaV8i2c1kq6hIMQJAW8BdlkY8LRyPH3g7SqLeSpXjK2HYw+kfjAMKqA0L6u8
 tTAiCJ84+P2mAC4W8JxjEgqOL0eLoMM6HLUJqXB+RNHvYGmmwfLX9QCM3lc7zcnBghdKNTLHHpq
 Uqc5p6awI9dCtP93Rv2esYcp1niZF9gWXlMm+fHmNJA0Wj8ZoiEqaV7+RSwAXH8cUSs3Go1ZEm8
 1CQHpJCgK/gU8fHZA5p2ZKiScXPjHumv79E8WDr+a9bOz8mhwK+cUNHSGv32GYehUoaKZHMNQN3
 rUy4kvaGpwf/Xg9tgWT9oyWWwdTxZmT9yq7NjmzyZ6aLdJwwy0T7leEUeQSdc0pufVAUzAK8iu4
 GHklUbVFY2lSrNiunUdcEQFQXXBDFMfAa3OiG7i45T1f6c4BS6A3JED56m5XRiZkzOZpcYruH/L
 vOOV27+b4tL83yKhN2cAwON4350oOSU60=
X-Received: by 2002:a05:6871:71f:b0:4a7:20fa:b5da with SMTP id
 586e51a60fabf-4a9076a4356mr6522002fac.24.1793659923193; 
 Mon, 02 Nov 2026 14:52:03 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a9218e97fcsm8578553fac.5.2026.11.02.14.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 14:52:02 -0800 (PST)
Date: Mon, 2 Nov 2026 16:51:59 -0600
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
Message-ID: <20261102225159.GK3309461@bill-the-cat>
References: <20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com>
 <20261023-mtk-genio-720-spl-v1-3-f2c0ee094fd0@baylibre.com>
 <20261026154825.GB646438@bill-the-cat>
 <fc38ac09-7f0a-4301-b78f-954dff0b475c@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pV9/yav64DE8DoSb"
Content-Disposition: inline
In-Reply-To: <fc38ac09-7f0a-4301-b78f-954dff0b475c@baylibre.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--pV9/yav64DE8DoSb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2026 at 04:28:55PM -0600, David Lechner wrote:
> On 10/26/26 10:48 AM, Tom Rini wrote:
> > On Fri, Oct 23, 2026 at 07:09:09PM -0500, David Lechner wrote:
> >=20
> >> Add SPL_ATF_BL33_BLOBLIST to pass the bloblist of SPL to BL33 with the
> >> register convention of the Firmware Handoff specification, through the
> >> BL33 entry point arguments that SPL gives to BL31. Without it, BL33
> >> still gets the primary CPU MPID in x0.
> >>
> >> U-Boot proper already looks for a bloblist in its boot registers, but
> >> when SPL starts it through BL31, the only other way for it to find the
> >> bloblist is a fixed address in memory. Memory at a fixed address can
> >> still hold a bloblist from an earlier boot, for example after a warm
> >> reset, when an earlier stage did not write a new one. Passing it in
> >> registers ties it to the current boot.
> >>
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >> ---
> >>  common/spl/Kconfig   | 13 +++++++++++++
> >>  common/spl/spl_atf.c | 29 +++++++++++++++++++++++++----
> >>  2 files changed, 38 insertions(+), 4 deletions(-)
> >=20
> > Why are the existing BLOBLIST and HANDOFF options not enough? I mean
> > that genuinely because it might be the case we didn't end up plumbing in
> > something here, for the not fixed address case. But I would be expecting
> > something like SPL_HANDOFF being added and maybe touching some more
> > common code path too.
> >=20
>=20
> HANDOFF would need quite a bit more work, from what I can tell.
>=20
> We are passing two kinds of information, the DRAM size and some reserved
> regions. struct spl_handoff has a field for the RAM size, but neither
> struct spl_handoff nor the ARM struct arch_spl_handoff has anything for
> reserved regions.
>=20
> Also, the same info reaches U-Boot proper either through SPL (when a DDR
> loader starts SPL) or directly from TF-A BL2 (no SPL), so it seemed
> simpler to keep it in the same form for both. HANDOFF is only meant for
> U-Boot to U-Boot. To use it, we would either have to teach the non-U-Boot
> BL2 about U-Boot's struct and keep it in sync. Or we would have to have
> add more code in U-Boot proper to apply the same info a second way so it
> could handle either case.
>=20
> Instead, we chose to hand off the same bloblist containing a devicetree
> overlay everywhere, since there is already code to apply overlays, so
> everything just works without much effort.
>=20
> Also, HANDOFF currently requires BLOBLIST_FIXED, which means all of the
> parts of the firmware have to agree on the same fixed address. To avoid
> that, we would need a new option and the plumbing you mentioned, i.e.
> passing the bloblist in registers from the default jump_to_image() as well
> as the TF-A path from this patch.
>=20
> So I could replace SPL_ATF_BL33_BLOBLIST with a more generic option and
> implement the jump_to_image() part, but it would have no users currently.

It has been a while since I had to last dig all the details out about
what bloblist was implemented vs what was intended. A thing that I think
might have been either not implemented, or perhaps conflated / tied with
HANDOFF was passing the bloblist from SPL to U-Boot, and not relying on
BLOBLIST_FIXED but instead doing the normal register setting convention.
And that's what I'm getting at, it should be generic to have SPL pass
along a bloblist in the normal expected fashion. The path on your
platform is:
Something -> SPL -> BL33 .... -> U-Boot
Yes?

--=20
Tom

--pV9/yav64DE8DoSb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaukUCAAKCRAr4qD1Cr/k
CvJ2AP0WGZcLJJ1+YCbo+9hTJivpfGxGc7Cdo3LKHyivRrSkZwEA2DBO6k0Arah+
hn7ONVyKhFpEcSqcE9aZS7QXkn83gw4=
=6kuD
-----END PGP SIGNATURE-----

--pV9/yav64DE8DoSb--
