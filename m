Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D282A606A330
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 18:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DUnpTr9C;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=be+ncvpa
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E5764078E;
	Mon, 16 Nov 2026 18:32:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2WIut5OJqEBU; Mon, 16 Nov 2026 18:32:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CB1B140766
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794853920;
	b=ECR+4q5D5k+KwCU//z9sgH3IGck9XDPl95qcQ6WIHsW+8LIbA7fvrlDUj7TsEa7AatsF
	 Hdqh3yFuuj5Sb0LccSXRyOaDxHpWQzq/UQK3lvZFv4tOA8c7c/DQIVrB11V0/fs9RJbQk
	 gadxA3aHG3CNjkMV93Pt6fB4zNMs4+CnJbN4Ycb/q/b9UVKXTSJJzdNvIFz6Honw/RHcG
	 +FYMWe8W8Cj+NRaeyUKxlDjMUqAZL9E2c+ClNE8b9YHsHTS/+KAUwDZ50yG0TtImq/j2U
	 4OSoqbKyxD59gGUnRNZ+sWSBPM0PMSq17HRUrQWqxGhYVxsS6aBkkdzsEbB6biKwi4A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794853920;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=8iBShbBqjdXaTU3ADmrZWxE668OMtYVM5GORLmuvpB0=;
	b=Rrflqh4370IOsp0jAjx5W9z4hefdJ6lj3nkzHO2Wf7hbIHOSLVvCdJ4FhwXTm4/DQd0r
	 ac4RqAxpz3EUxOSUebsr1EN8L0vlPItrUO8t/UxyLCXnHgze3S4m/UPYa6izr7acMN07b
	 maXkykTX3vhXFrrJPUAa/VHx8fgAmFk8Bukm/UupTCNGAs8iAdRlUBpCiVDg0fJ9UX/Bp
	 KRDDMN7vk+7BwMaoqdvLB+qQC9Z1ytikGEXAHYdCOjr6tL5jgqlWAkC0ZsS8M+r+hCIDH
	 HmYV13xEkQotIBT+KXRMsmf4e1nYt3EP0RhcxzsN7O++UhvjLJIFzWIUUOtbL3pbIag==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794853919;
	bh=8iBShbBqjdXaTU3ADmrZWxE668OMtYVM5GORLmuvpB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DUnpTr9C2gwLWLaqEMCk+bnuaMv86RwSBeMmdjrbULMpqwZnn32F5308zw4bQHM9s
	 ZrnEyPjiSP4U2QM4QH52PuMGkTnbe2zH3c6HD1QCVfyS1cEBjYtOVZ9ZK2/TR5OeRi
	 aVPkcGaboXqtttmBdqnJTI6B/UsCNBHMsut2hPtEywLEViqn7Q0gfWwGbrTlt9vP5x
	 gklJAPt4T81UQxgztoGWF0O0p58OzAYHaheEr03j8QhF3b/JsJdCqPTsXW7RPuHxLS
	 YiWu94R3TiG031XZeOzJMKrNmVzRo7G3uoK3qN4WlVUBYDqbE2thdxkKGMFU3AnEo6
	 ACgOdLUquuycg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB1B140766;
	Mon, 16 Nov 2026 18:31:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AFA728C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:31:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4DA70607CD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:31:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MVKIqc96mRnK for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 18:31:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8431960763
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2d; helo=mail-oo1-xc2d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=be+ncvpa
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8431960763
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:31:56 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-716b58a4365so2502010eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794853916; x=1795458716;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8iBShbBqjdXaTU3ADmrZWxE668OMtYVM5GORLmuvpB0=;
 b=be+ncvpaGGXLGjCapjWhYVIheAgdJxJD52xWtEPcW35GnkzLEa3wwvToQTDOJ7B2/d
 OqSDMGNcWAKm87zqOnGVNpp3l3BGDc48NaXvOSSv5DVRfisWJW3Fs7MsOrGpoJLolVOe
 PVX88YKJsvoE2kg3iMLBNCdyrt6JU96ZqFgBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794853916; x=1795458716;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8iBShbBqjdXaTU3ADmrZWxE668OMtYVM5GORLmuvpB0=;
 b=NOTOsilGxFayghXeBOJdsFY0JqTASNAxEqspmrNCIpaBAs2rXjdS+LVFOKQ4R8i3KJ
 st9JBuWQwb9WnZ78k6eLL8XCVyWyOL09ChP7zENu+olRfalrcWjRQlCyK1u/elnOLpd0
 GkegbDcVbQiVRtrvx8SLJscGKUlzu4FUMglb213XNQOA27W8Qv6Qm+A6ulCzEuOkQ14X
 UJmiFJYLnNM09dZInkj20cpsCAjfyZqmaaI6lXKen5biRWfnmRb6x/P/QJRodTM7GdYS
 nbYPdZxFqXejTPNQ4e7y0PRg38O/jrm4bmAxEO/M5wJMb8UPLzQwYAhsPZY8kca5HlW0
 RamA==
X-Gm-Message-State: APuU4Z8wRx0eHRV/NhmvFwp2FRCkhiz/2DVCleWt/3XswsP83W2bl6+O
 sZXgSn2qOHiwkfUBaknV4HXugrlZXOfu92P0T24CgeHd8XqFpydQChvx7RlEDuJt9aw=
X-Gm-Gg: AYBFou1CsqnJ1wD8SkSUStYaLlXLFi053C7pjehwAtzAszXAChgQU0LTBfchLmGRaxM
 6MLXMOweZ8LldLuGZIYoZ078PxvUYCxXhoasX695NnfsLI7GDBs4kP1namtOrkPVe9JKL5DgLTY
 P96WkcfZIC+G1JVe8t7Rj8OueCA1zy1myeQoYuho3GFpm+Cu+L+UUTRhnZPED8PQlN601DL44fl
 CGpKk8thR+QwUAxMBSg0G6KESANf/yUW5/AAR0zO9N6sNL3xl0Jw4GOTbp0sx/kq2F0sWqaKy35
 HeDkEmZrp7hM3fFIyyc28DrwNEUbgB4nHK+6kRHDxfjd0U3z0JX49jxRn853B13wGoZfmrmXApx
 +q6RlDQ/C0bZzc07uhAkSzm5ETsm9R2ZJiTjNKeO/mY/RiM/tUK70mgu/a5ChL6o7EgVbDm68Wr
 XLAlSswJovGS/UWFT3bZFUFtl2Brgaqnn2H2aCEQ5xLdPLn6qz4CtzCfVjvciaj/KQCeRz9R/37
 zuPr3E+hLnz3iIdcmmiirLDjjNnOjAHS8A7pLbLO3y+aBGW0HSqSOhSQrfp7RtvSSMZRYkr5YJ5
 7XyioDNAzLcF5csMm2siLMLU1VJaoPTwkp0KR07dBHnLyiho46Ci4QOjyqxf+MMsqP9a73Tu6LE
 sy3+zNwul5YOgsj1+7omKfP6xTy/bZC9MHcaW3+feE9NHKnYA+5uuCOffYyVJ614dW0a2qAYt6m
 bwFBqdIdz2P0ayzHmS8L3TNqfZEPLSn1c=
X-Received: by 2002:a05:6820:c5c1:20b0:71a:ef4a:8684 with SMTP id
 006d021491bc7-71aef4a8e17mr1978546eaf.59.1794853915721; 
 Mon, 16 Nov 2026 10:31:55 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71ab42cc12dsm9132452eaf.7.2026.11.16.10.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 10:31:54 -0800 (PST)
Date: Mon, 16 Nov 2026 12:31:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Javier Tia <floss@jetm.me>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, David Lechner <dlechner@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michael Walle <mwalle@kernel.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH v4 1/8] disk: Add partition lookup by type GUID
 functionality
Message-ID: <20261116183151.GB554944@bill-the-cat>
References: <20260428-type-v4-0-b7051dc45a88@oss.qualcomm.com>
 <20260428-type-v4-1-b7051dc45a88@oss.qualcomm.com>
 <a5c42652-7346-4775-a13e-e9d74c393ee6@cherry.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vZCQxaLfc0dh9iNB"
Content-Disposition: inline
In-Reply-To: <a5c42652-7346-4775-a13e-e9d74c393ee6@cherry.de>
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


--vZCQxaLfc0dh9iNB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2026 at 03:42:14PM +0200, Quentin Schulz wrote:
> Hi Balaji,
>=20
> On 4/28/26 9:31 AM, Balaji Selvanathan wrote:
> > Introduce part_get_info_by_type_guid() function to enable partition
> > lookup using partition type GUID. This complements the existing UUID
> > lookup functionality and provides more flexible partition discovery
> > mechanisms.
> >=20
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> > ---
> > Changes in v4:
> > - No changes
> >=20
> > Changes in v3:
> > - Addressed minor corrections in part_get_info_by_type_guid function
> >=20
> > Changes in v2:
> > - No changes
> > ---
> > ---
> >   disk/part.c    | 37 +++++++++++++++++++++++++++++++++++++
> >   include/part.h | 21 +++++++++++++++++++++
> >   2 files changed, 58 insertions(+)
> >=20
> > diff --git a/disk/part.c b/disk/part.c
> > index 4923dc44593..4cb3204ac6e 100644
> > --- a/disk/part.c
> > +++ b/disk/part.c
> > @@ -731,6 +731,43 @@ int part_get_info_by_uuid(struct blk_desc *desc, c=
onst char *uuid,
> >   	return -ENOENT;
> >   }
> > +int part_get_info_by_type_guid(struct blk_desc *desc, const char *type=
_guid,
> > +			       struct disk_partition *info)
> > +{
> > +	struct part_driver *part_drv;
> > +	int ret;
> > +	int i;
> > +
> > +	if (!CONFIG_IS_ENABLED(PARTITION_TYPE_GUID))
>=20
> We don't have an xPL symbols for PARTITION_TYPE_GUID so you need to use
> IS_ENABLED(CONFIG_...) here otherwise it won't work in xPL stages.
>=20
> Or you need to add an xPL symbol for that (see PARTITION_UUIDS and
> SPL_PARTITION_UUIDS).

Jumping back here as I see in v5 it was switched to IS_ENABLED(...). I
believe the correct approach is CONFIG_IS_ENABLED(...) and introducing
if needed, or just waiting for the need otherwise, the xPL variant. This
is because I can see for size reasons xPL and full U-Boot not having the
same environment notion (perhaps NOWHERE being set) and so we instead
run in to the other type of compile problem here. Generally speaking
using CONFIG_IS_ENABLED(FOO) and later adding the xPL symbols, for shared c=
ode,
is better than IS_ENABLED(CONFIG_FOO) because we want/need that
flexibility (there are counter examples, but they are the exception, ie
we *must* be consistent from phase to phase or know what a previous
phase has done/next will do).

--=20
Tom

--vZCQxaLfc0dh9iNB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavtMEwAKCRAr4qD1Cr/k
CnDhAP9nOjRScUyhWE0Elr8eDuanb39ppsNjIYhWvQ/7va1lIQD6A29Xpbrdrcb7
Q+2N8g/S+5PkBBASlmNLZkYdiVZMlgE=
=DL6r
-----END PGP SIGNATURE-----

--vZCQxaLfc0dh9iNB--
