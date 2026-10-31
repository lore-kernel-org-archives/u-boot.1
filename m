Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDF4606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WhramPrv;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=DoW3iS9m
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF1BC40AFD;
	Sat, 31 Oct 2026 14:12:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oS-Kd4Y6-5eY; Sat, 31 Oct 2026 14:12:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7424740AFE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455955;
	b=Z5QnG2pvQenRZlT6744jwmEvVXIw7CCpBOwtTDzAhLG7zGDSl7kMrf/ElbUynuodJLpM
	 kp/0q1TWTTjWQlcsuas1eCf44BrxQuZ+sk0UaZeO7I5cfWWlzxfKTCwAa5l9y3XslbBUG
	 gKu4fy6Bq2njXtXLX8UwBhXP5YjekMsB3+2I3r7aQOIzfxEM8vg2rrjsdHM7BZOG+MTMc
	 hPDz1QkpDP+lxUTlGKTPx6JfalXuYKUFFY4LeIn8RBI09OkX4ZDmd1qbAeFImoCi97mS7
	 1czFh2JWvt1U15Nsjy2iI+iSJMS4pRahTYPnSFLDH4KnhYCJJoRK/f9dNeSfYUNUnpw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793455955;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ex4mm9xGmkPgWIwwUQtrYFnXbqVADUKHlvSBclz+4+s=;
	b=H32uVgrTJPVuctc+Cg/hyzFf0NLGsKNcueWUCkNW4Z2AOsQV2AfI5rmBDRupg+KT3Imx
	 iqomlP3+LZmdclNe1yyV/GVXiBDS+GkQV/d1GQMzmMM6iFh1aw7j/wmpoWgEQ++dFlW3q
	 hsM+7GsyUpMScMdOeanCLHshHlzo/TDH4PE5TsppHiRkXBLG+5d1vr0A0VzTyZleRxXMQ
	 AK3pL8hLobZtI5uaJ4izbYpMfOBu7f2Ah7cny8ZFHEd/o3G6vvjEJPimquCdycIOAjfat
	 ehWn+R6qL7iawgcYLLWeVTbTYLg2IwWMFwe4yLeIjC/Q7Yk9uZWNa2/542PsZyYc5Yw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793455955;
	bh=ex4mm9xGmkPgWIwwUQtrYFnXbqVADUKHlvSBclz+4+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WhramPrvN95GC3vK8QBhO4z3xRorGT/sgZp+uGM9FN2WTwYELR+Wl5N1PqBLWBaWg
	 iNr2h3rU+hZ/VaLH+41RqaMSUYKrRlon1JoeMzifp/GaZWtSjwyEXPsq3vTlJVu1nG
	 +S3i4baXqLCPG8F8QnzYvAryBVH/PDwXndeZE2pro78mb2y+dwT0oCCZwVzyUk8C5T
	 gLmNzQCFJdzS3AJrB47RUh+qi0kufI0MHlFNIBJCRaKNW5FQuNWEhYLdEoUFIQ1GVS
	 LYjLmP6ZRtqXvKGshgr6WgknCnketqIFGx6Ek/TDBkm8o551325elJQBIcIeSW9Kwa
	 ts7jzmJTE1+pw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7424740AFE;
	Sat, 31 Oct 2026 14:12:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 227E7380
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:12:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 083C240060
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:12:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sb-aeDtXUF96 for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 14:12:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CE97540049
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::343"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793455953;
 b=CWepZirGPLLgKAM07nSJCt2k2y9JZqFvfdhFlRFEyqGNEZaKoDijjB2HrBH6Amee4W55
 hUTr1s1Idv0KISo/1R32e55CHBRo7h6ocXl2qllRc0+SrxVVD16m7DljlbvQrmiokXrcm
 jGPBYbIsDY8mHhcDS/gYLBIQ3Wgz2/2pSdiKwHtBrgKDKyHDd8eMZqoiwagWtrmIInV9V
 Ds0mPWoOd4JbBZhDHsiYP/MILv9ur3Zilt8McN6t4SLqyHzAO5kGvUSJ98FzJH7RariLl
 KT/xE6LK4J1ifUlU8zTYK4P0aWo/N1X+OcUSfVcckyZOA+wyycMQw5EgezTG41jO2mw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793455953;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=ex4mm9xGmkPgWIwwUQtrYFnXbqVADUKHlvSBclz+4+s=;
 b=P6mf5JNPAb9Jr9OmWf6bHCZHSpslI1VRDbEOSj2HIn6ypNfW9Bsvxjnjazjk+zT4scYY
 IDKJTscuRYOCaQyuGvienScrX3JLwzkf54OQID3I4zheUezkPAs5zMlVQbW0mgsTL8Ead
 lenbwZyjpxq9/MBqepUZyHXrkmVxRZnpAgbZljtwfPsz8keSn6d5nLl2i7/u3kfjelEMr
 8/S+j9/Y6cMM+167JTIXXdV5S/XiL40Jci88FM+f87PqRaHobKWKYQ119jDiHNlubZNwo
 Q7Yh8Ddbg/K8mT+saHL3JfvYq7IVtz87BNzLiUOkn1vRIZ3AsWjBnaTIYjbLR37prWg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=DoW3iS9m; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::343"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=DoW3iS9m
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CE97540049
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:12:30 +0000 (UTC)
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-846566246e8so1661597a34.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 07:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793455949; x=1794060749;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ex4mm9xGmkPgWIwwUQtrYFnXbqVADUKHlvSBclz+4+s=;
 b=DoW3iS9mKIhfLSgSFdl2IBU7HkAzzbculDKtbpc9temIbA76tWp3GvF2F0qLAivpc9
 MpGDIni1NvmWHYGpOpP3g6jQQpc7Ht9yWcPmF/o/NllIhRJUkXGdBGje17nEjEdJjIL8
 eLorpEu+N2y5D9lK9RycuzUT2mOdovVe8LtsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793455949; x=1794060749;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ex4mm9xGmkPgWIwwUQtrYFnXbqVADUKHlvSBclz+4+s=;
 b=VucL7BEGWvvX8WbEaJzqI05qvrrVc5eW694GSoRaH/FZejUStW5amxHIcBoHXo0w1U
 szUhyqO7auUNOXl5FBg8eZ/30fhDHufU6vzzc3GiUDT+TpfPbm8SdnEFui9+HP57l1Xh
 BwuOdByDw52pU5yp4uYtlEZONp7wbyWwZBKLrClzDoFMsLO8p+Tw866MXFKSjp2s9B0E
 QluTs0XkNfdm0cww3FrVRcqhIotilzSymmJ+3xVoYDHq0lVuIkYS/oRBvT4DAE4iSY2m
 v8Zq35zZFYg2LJa0J3GrV/6Uu4Mu1OboceEkESmir3Y9wuXidb2Eul8tRisxSVkeM2Hh
 +L3g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlfL8SlQ/ByCaWI4kG3akd7q2/EHQ7aFXCqqFNYOmH3WhHKNiEB9buf0AD9cjyemCVMTrHgAg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIZuVFXEGpHq86nVXwmAQAbzg1P6CzyTJmLz3NLrkGkLhL6BdoI
 2/SCy81s5zoJrzwkfFyUZn2oESt5Wkdi0rI8atxlh7t9hwKIg4M1k8QZic9cNycv1tI=
X-Gm-Gg: AYBFou1MBRfS2n8bayWCB0DbY7guTqzfS0UgeFvsJ8E3qG5ylAw6nXz01nXzDxRbcOs
 uilDINO9e1DXfahxBJ7SU5ma0FyJsKv1OhPKMqiUAOiL3bYkO526NKcHBzv5jtbiHP/TSE/LADC
 sBBs1nH53injLGq4VBbl1w0UMjDUBSLC6NVtZzgkOoD7j/zbjP5SIdHOTVupCK93WCCvdjuxa/5
 idwva1/91Aiagj6Jph/sdVb3ELro5C+BIVfYh3t9/By3C0cDNuhpydiuA0j0poe6fW09b6k7JVV
 FjgkWTf3sQUmsODDyqhnsApeYMh++phUgsKgs1mg+oDVUqgPzUOgfb6cLldeO7tAM8Tlm4po9mW
 GP0NVlA6f5pYydrcUEZ3uXOLPwNAlXv/4fnyOpVxiDRea9eqStyfax2LVy9YKoqagGUIOpMymhx
 7G1RUD+9L46BTDRGZwbXWAm6pEoJwBHIMc5qJGwO0rv1chDJrilJszRqVzTtVTPBE7oQ1skVlEE
 1+wjoUAJTEKl1JYJdYq8KTMmKX9CGoRyP9Ce5T4ZOLkFvK7u61pqKgmH2x/Av3H3QoQ3YRv05Bp
 LGqwPwGTDQ7vk1z3MA2UtouIopZeR1/tGIluN8Vv1JZibUhe3Y67zOfh78T123vq2O0m1MEUPs/
 qOoK3lC35YbY3PInjtrT7BKd4IqdY+qDoYqrXTaxlY7OHNPiCcA3pcgMCCa7x05s79qljtDjxDq
 uo70kU32hJCj7d7/Ne3NO7n/5aKJN4Vv0=
X-Received: by 2002:a05:6830:440c:b0:845:614b:eab9 with SMTP id
 46e09a7af769-85c20a9eccbmr4439716a34.6.1793455949307; 
 Sat, 31 Oct 2026 07:12:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d3545b847sm4432189a34.7.2026.10.31.07.12.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 07:12:28 -0700 (PDT)
Date: Sat, 31 Oct 2026 08:12:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, u-boot@lists.u-boot-project.org,
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>,
 Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH v10 0/7] Improve FIT signature handling
Message-ID: <20261031141225.GM3309461@bill-the-cat>
References: <20260923114940.349985-1-ludwig.nussel@siemens.com>
 <CAFLszTiM+-BsYPjaw7aD7xfzU+3kK-BO9mkYKrtXpjPOv4SjcA@mail.gmail.com>
 <11fb0589-8ef2-4870-8490-077389ce9e53@siemens.com>
 <20261012144457.GB3722450@bill-the-cat>
 <44849c78-b187-4a20-bf2c-0eebaf8a2e9b@siemens.com>
 <20261013150127.GA4042005@bill-the-cat>
 <CAFLszThDcdt14Chi=UeO0i-gpzUvXMQR1Dd8c1ZVVk6Xgtvidg@mail.gmail.com>
 <20261019181943.GD720525@bill-the-cat>
 <CAFLszTgb2oQ0ffsZqcsTtD78ObQRJDFvC4awtAGozAMWrdMKiA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d38/O36HbYctM7G9"
Content-Disposition: inline
In-Reply-To: <CAFLszTgb2oQ0ffsZqcsTtD78ObQRJDFvC4awtAGozAMWrdMKiA@mail.gmail.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--d38/O36HbYctM7G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 08:54:54AM +0000, Simon Glass wrote:
> Hi,
>=20
> On Mon, 19 Oct 2026 at 19:19, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 19, 2026 at 08:57:41AM -0400, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > Tom Rini <trini@konsulko.com> wrote:
> > >
> > > > But then we would need to provide the whole device tree, yes? I thi=
nk
> > > > this ends up being a tricky case because we're on QEMU for this. We=
're
> > > > just checking the signatures on later loaded FIT images. Maybe the
> > > > series that adds SPL to QEMU could be helpful here, since we do hav=
e a
> > > > normal path there for applying an overlay to a device tree, I would
> > > > swear...
> > >
> > > Agreed, a whole DT is the wrong direction here: U-Boot cannot know
> > > QEMU's runtime shape (memory, CPUs, devices from -device) so it must
> > > keep using QEMU's DT at runtime.
> > >
> > > The merge code in patch 1 is already doing the right thing in
> > > principle: take a small built-in DT that only carries the signature
> > > nodes and merge it into QEMU's live DT. The remaining gap is just that
> > > OF_OMIT_DTB=3Dy means no built-in DT ever reaches the binary, so the
> > > merge is a no-op by default.
> > >
> > > So I think the fix is to arrange for a tiny signature-only DT (e.g.
> > > generated by binman from the keys, like the normal vboot flow) to be
> > > embedded when FIT_SIGNATURE is on, and leave OF_HAS_PRIOR_STAGE alone.
> > > An overlay fragment would work equally well and is probably cleaner,
> > > since the intent really is 'apply these extra nodes on top of what the
> > > prior stage gave us'. A test under test/py/tests covering the merge,
> > > perhaps using sandbox or the SPL-on-QEMU path, would catch future
> > > regressions where the merge silently early-exits again.
> >
> > So as I kinda thought, we're in a funny spot here, because it's QEMU.
> > And so yes, going the overlay fragment path sounds like the right way
> > forward because that also should match what real hardware would look
> > like (we're given the tree by some prior stage and need to augment it).
> > We might need a little re-tweaking of the Kconfig logic (some new flag
> > to say we need to build overlays, and not fall back to "and now we try
> > and build a dtb for the board") is probably required.
> >
> > > I can't help mention (again) that this would all be a lot simpler wit=
h:
> > >
> > > https://patchew.org/QEMU/20250405191352.2597585-1-sjg@chromium.org/
> > >
> > > ...if we were able to explain how U-Boot's use of the devicetree
> > > includes configuration information.
> >https://patchew.org/QEMU/20210926183410.256484-1-sjg@chromium.org/
> > And I can't help mention (again) how unhelpful it is to bring up ideas
> > that were rejected for good reason.
>=20
> This prompted me to take another look at the thread from 5 years ago
> [1] - it's been a long time! The objection in the end was basically
> this:
>=20
> 'My take is that this is u-boot doing weird custom things with the DTB
> that aren't "describe the hardware". You should be able to boot u-boot
> by putting those custom DTB extra things in a separate blob and having
> u-boot combine that with the actual DTB when it starts.'
>=20
> So this series is responding to that. I have heard a similar opinion
> from a few others too, but that doesn't mean it is correct, or even
> then, that projects should not try to accomodate each other's
> differences. At bottom it comes back to the 'just describe the
> hardware and refuse everything else' thing which comes up from time to
> time, but that is not how U-Boot works. For good reason!
>=20
> Perhaps more bindings in dt-schema would help? I see that bootph is
> pretty common in Linux now. Would adding verified boot's public-key
> schema to dt-schema would make sense?
>=20
> One point raised in that thread was that allowing users to modify the
> FDT using the QEMU cmdline is a recipe for breakages and user
> confusion. That seems like a reasonable concern to me, although of
> course in practice it isn't any different from having U-Boot do the
> merge.

I wish that when you're told No, you would accept that and move on, and
stop bringing up or just implementing stuff that's been rejected. U-Boot
doesn't "need" something when you immediately follow up and note that
the problem can be solved in a way that doesn't change upstream, either.
Looking at that thread again, yes, you're wrong. My current reaction is
that if you had gone with adding overlay support, which you explicitly
call out not doing, maybe that would have been accepted and would have
solved this problem.

--=20
Tom

--d38/O36HbYctM7G9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauX3RgAKCRAr4qD1Cr/k
CmyOAQCpg34ysJBp0PLPs89kA5J84antiPXHY+tXIjujA0uMggEAy/IR9WA+ojYU
u2T25p0cMlfIhBGXCIP6yyYNEZXWCQ4=
=i9s+
-----END PGP SIGNATURE-----

--d38/O36HbYctM7G9--
