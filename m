Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D95D606A319
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 04:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GiZK68EO;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Duco1SxZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E6EC81361;
	Fri, 23 Oct 2026 04:59:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IqKWxhX4rKtf; Fri, 23 Oct 2026 04:59:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6587281358
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792731574;
	b=tNTnzl6qEDBGDjNR6dbe1BktPBAcNhUjfLEMoB0GvJHxQUhvov0FjJiMyd1iVbRFxpO7
	 Vn8hymtC8IaYaV+/QWWv2V/wFBLAqQXnHzMOVROu16ZRYacANf9F/+GdPN0be8Edepcc9
	 sr5z6yvwP5E+H3tEF2I7LYt4sU/ruOKp+SJyqZZBP2RsA+TPUhuxItm/1HmL5JvvTiVvX
	 /eHhto8Y4JcpCdXTiQxYrpBaayLrfftit+zNYNTTCveL7H6GU+iw2EC/YpfAUrAvg6WZr
	 IYFVOg0YTsI9NpwYGUj7QoDk5SPuoGUQ+WC+MbZl4ydTLEGIXV0oWgVNqRKHiNA79rA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792731574;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:In-Reply-To:References:MIME-Version:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WtrrT6otz8IjzUMFDN6+wSxZJ5GHsil88nhFXTJa8tU=;
	b=pYfXLBnjPO6Gji8naxj5k3Gr4UAQx1IPTVSHrF+kx4fOy5vFAG3wH4qhFWcVD3EUPOxg
	 A7LT6Do+vtXEgvBaUk+2o2Foe6gFT4kQxLR7lQtPNE0QUOT3d6/Gu3abrY2Ay1SyKOhT1
	 9PekcvWYekv+uGb9H0LCz4Gm23kThK5mt8ekCBJfvkCXf6HB9Bc/Sd+Gz0OftGj7XFSWe
	 m0susc5pnHit6b3GnOmXpwAXNo6OttzgDyIxAvDgDxabj0ufLWwflbOA5WzluIKkv0jGm
	 7e2m9Z4NzT+rZv/9tqxiR18A8wz362sLbIzZOsbxG57mDIvYVBSghgohY+0NokEaxqg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792731574;
	bh=WtrrT6otz8IjzUMFDN6+wSxZJ5GHsil88nhFXTJa8tU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GiZK68EO3+pfMUgJeLf5zsZ1Cqyt0w6BFf2PaqYpa5xhKlUTRK5/gAOOkujQH+Lzs
	 NcMGw0/GrVH4n1xafqA1ocJG+tZwpvcDYZcq+cdqLvGxfjYcvbEz2nKI0lSzQBJ3RY
	 lWObeWw9DlISWpX+U4tkkMUHS6zvd03bW0YWhLou8ToQ4WTiEtLHwxurcZYK43dTl9
	 B4iO/0vBE2BAtEeOulpCH8mmh74PTBCv2uywXrUTeq50EwVYxAoa0e6ccMaWIZQytH
	 J8TdUAMf4gwF0Oh1v0Wvp0wj558TmQs5wPwo78O9BFYTRA5wJ/WOTDVFGthxA1Xnb7
	 EXsa3JxLH+UFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6587281358;
	Fri, 23 Oct 2026 04:59:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BA5A4356
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:06:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9FE734095F
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:06:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4SsVLjRDc7WJ for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 04:06:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E63124092B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:32::b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792728398;
 b=FR74xkGxKIuDf2nZNIApafHm8337GSsuyV2mnVU95lAqFQXfsxZAhvoqbaLAxp6JAGrs
 y+iy3gkssZJE0HzQF1JfOT9Mfs5WiWBovDLf0GI1xXrFX4Hi/9qvqasrwyOHod4mAjoiB
 0L9sa/OEC+CsmngYdwOClhdg1HamW1WuTsiJefKIoEs4DRBlyEc9nhOlmZmWsOH4jpcr6
 l5FTdd1WgXfTAWDNftxg5q+fGQCETV509qfZTrfKCZ6bN9GiXxbjU2+nkYJGP8lqKW2Bq
 iMOjuLsgMAScETvWBWNL2X7rJ6VcZzQB02J6lftWKL9yqGzFSpoJKO+RfsEh7K+0EHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792728398;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
 Subject:To:Cc:Content-Type;
 bh=WtrrT6otz8IjzUMFDN6+wSxZJ5GHsil88nhFXTJa8tU=;
 b=dtpImYnTZzdZostp7rUpreDv0IgjNNuO0boQ4BCeejlO6rlRr9iEghKQFM38nBcGWMEr
 6ScyYyYZhcPqbqrK+yyJDSK3be035BQ1/YJlOF+MPxkZI+zulwAJgh3/tcgW/jq512qKG
 MYqm4ZuO0CjEFxylnA66rsS2/sMTUDcNGRosyKH4S+ypwnE9Xha5lN4MKJoXklu9EDzLp
 tRgU7xGhqk1Axql9VTFKupnfS+Nu7ND8aS9eOdhJd+tlViq0MMgyLh5dECus4soeML7kk
 ADZ19bfX7FuqqzJsHBU5plmKhes1ksOXb6fs6XXdNDCvZZSorm5YRUpOqgUMsvXkcfA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Duco1SxZ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:32::b"
Received-SPF: Temperror (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::b; helo=mail-oi2-x0b.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Duco1SxZ
Received: from mail-oi2-x0b.google.com (mail-oi2-x0b.google.com
 [IPv6:2607:f8b0:4864:32::b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E63124092B
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:05:28 +0000 (UTC)
Received: by mail-oi2-x0b.google.com with SMTP id
 5614622812f47-53c4858eb76so215286b6e.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:05:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792728325; cv=none;
 d=google.com; s=arc-20260327;
 b=niXQJsP/Hcnj/IqzKWuqldfsxu/d+Slr8YibwVxvoIbgO454waEc95gYHOuirDU9lO
 PENXc1velPZi3DKMvTvt017TUD+InCc3mhQ1ZWtJqz/ZCGP22L5TdZJ997sbG5KDgCQs
 g7dlw5Yk1gwA5DTJQFflamtg+5mcnjFq42Z43JyddFKM44Pnhp0s/Cki8XSY5ipxYMxb
 NRvc4rPA/vBb5xKxQ2K7XKDSPgIb9lzVaopbwDm55oQ7yWdIKjo1bSnDCwth483q3G67
 aZjtrznolAqS4H8G8hjLCqE07V8nVGCWwuUAE2TfuUbt6SLfviEFWyCenwAUHBQQvywj
 /Fww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=WtrrT6otz8IjzUMFDN6+wSxZJ5GHsil88nhFXTJa8tU=;
 fh=fO/i0n3hYJ74cs21KGuyGF2OazYql2f81AfdSYYrRi4=;
 b=c0wFl6Xdua7tvR4DkgPS4Idgq7uEm4ow9sXz8mh0gnKf+4d3J8a8LAgcVg6PkJ4bZJ
 scfUjMq/VJkaPGFiTtxX+xdw3mer0KjfUGHV9EisW5ZnGoxghp+m2vg37tveKs91Dtj7
 rlGKgQjaCCg/MTmWPPc+GJByfWf150qIntSXj2oSFwcVuJv3TG1FNqQZQq//qclBzOd/
 vtXp9HNVO5O/k+Y85SPqpfcr/lgbIsbwjTVO9PpgmSg5keaUD+LWVfmwnBF9O81BwhYM
 LpNE2xYLZQhse9OJrEKynKoZnY8P6PASMa5RiVxhSTlBYFGXsemLP6cANW/+HLNIObAm
 CCfg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792728325; x=1793333125;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WtrrT6otz8IjzUMFDN6+wSxZJ5GHsil88nhFXTJa8tU=;
 b=Duco1SxZDII3qZE1pJNV9B7kCLJZO96s0TXFD63F6r3Vh7xtCj7m02EyhE50xWB0TI
 L0xjBPPpYNnlM/2dnGHJfVlmZ3x1sjzrVJ9yywQ5jJVj9R5M4x0Mjsmt4qfUge3KQqrm
 UGIYnsYWTJ/OZs1yTLWPVKkmoqoI9flUQQzfdJalmHg01k2Su6ecSGJQlR4EU2oHfTrY
 Sl+ZVkDtpn8z+/5ZAy4WWU9kz36OayAVrHuzjbwjsJnoOYJ7hBsedNp7NUGM+aWCxPdf
 NnblW3XTToBJdKx2U845YboyELPJF2qU0B5WRUqX4tWhNtEPEAgLzpdkbf6OiIJeeM3n
 nWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792728325; x=1793333125;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WtrrT6otz8IjzUMFDN6+wSxZJ5GHsil88nhFXTJa8tU=;
 b=A36ISyu0wAYd52nSpdd2Clpg1+oV9nDhxUSc49/oOIPsaQhfa9feRhzSD/MFOXFl0U
 zjMy+ETa4V61WmXepOEbC1yy5Yj8Ru9b8eYRHsWoFyu0VlSgWPTm10JqChCi+0Oqc5Yr
 TgCcbE9/OnQ9nxAgWfEbv7nVonBR88RGTTSuYvSeM/WZusdsAhHk6x7EQAEszo5wspo3
 W+pYEDrOZR1m2/rXCAhTKFCIDz8VfCdFSVrbJKK37zvni4IJevcxM+EawVcUjyQ0+cCl
 6LIAQpb0srIjANlN90ePVY33wM214yOWEftwTLuiodPHvolaTVcON+nmo1CrCYMKmQFj
 km7g==
X-Gm-Message-State: AFq9FYLGJF/wSNrURbnjnihEtOM2zyOQjB0aP8fbHtpV+bC0AQFMHgIO
 CYlL4N3Rg0dIYa17kti6Rb1E/ilD2JHOJUGZUsdts8HSzK1/Chmpnqz03jo7yowQ5oRSkP9fIe4
 pEFSWEZonUVHuVW7Go34eJK9kT83XAWzudFLJtq0=
X-Gm-Gg: AYBFou1Zod/8ihH0GgoY5/Upcnkzcj8XHA+7LwTq7ZwHy4+cTHsS9c9SxhcLpIlkP1V
 JrJHsJVF9fdl6VQsvAVVVt4P543CrUahupC5GDaYDRi4j0xiCVWAjegYRI7WlXach/tJxzyp4ny
 uUHMBavHiBwlNPUg2Aib1PUkJmBdHBuxn9oNCRzVWJKmA/yfmzJhBE8r+PHpDZeKvTPTvR8vE+y
 +PFtm96a4WxWRr+Ehsi/bBpLL0Ul2guPoGs5xswgDBeskVrUuzG3IJszTubLH4QRQniIYs8uQA6
 oQBdkNFmeZMLd3IGmb1LAscgxkN51nxfhycNVZiKA7JLaRzpXoDPnnETVKn+6dSidg1eYW3qavc
 DM5FHhNmmTjnSFUQW5N9sxhE=
X-Received: by 2002:a05:6808:1b08:b0:4cb:abff:3db9 with SMTP id
 5614622812f47-55be82a0bb6mr650260b6e.9.1792728325669; Thu, 22 Oct 2026
 21:05:25 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 21:05:24 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 21:05:24 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAJnxHsh5DbQdf+UfmbSKt7xY4QvecGWdVzSo-xEFgM8yTBCHXQ@mail.gmail.com>
References: <CAJnxHsh5DbQdf+UfmbSKt7xY4QvecGWdVzSo-xEFgM8yTBCHXQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Oct 2026 21:05:24 -0700
X-Gm-Features: AclHuK-8iSK7ZG1j1CjUW35VAmMe_pCjaQuMouHzH9IBMAfkA1tRQeLOwmZC3MU
Message-ID: <CAJnxHsi97r2M_n-SQ_2L0i3RPaXUE-dCKv-t353q3=U4UMP==Q@mail.gmail.com>
Subject: [PATCH 2/6] fs: ext4: fix the triple indirect cache check in
 read_allocated_block()
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>, 
 Simon Glass <sjg@chromium.org>
Content-Type: multipart/mixed; boundary="00000000000007e61b065e7a176f"
X-Mailman-Approved-At: Fri, 23 Oct 2026 04:59:12 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,T_SPF_TEMPERROR
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000007e61b065e7a176f
Content-Type: text/plain; charset="UTF-8"

From: Ana Bobillo <anabobillo3@gmail.com>

--00000000000007e61b065e7a176f
Content-Type: text/plain; charset="utf-8"; name="0002.patch"
Content-Disposition: attachment; filename="0002.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: e5549cd995e1d6e_0.1

SW4gdGhlIHRyaXBsZSBpbmRpcmVjdCBicmFuY2gsIHJlYWRfYWxsb2NhdGVkX2Jsb2NrKCkgcmVh
ZHMgdGhlIHRoaXJkCmxldmVsIGJsb2NrIGZyb20gZXh0NGZzX2luZGlyMl9ibG9ja1socmJsb2Nr
IC8gcGVyYmxvY2tfY2hpbGQpICUKKGJsa3N6IC8gNCldIGFuZCByZWNvcmRzIGl0IGluIGV4dDRm
c19pbmRpcjNfYmxrbm8sIGJ1dCBpdCBkZWNpZGVzCndoZXRoZXIgdGhhdCBjYWNoZWQgYmxvY2sg
Y2FuIGJlIHJldXNlZCBieSBjb21wYXJpbmcgYWdhaW5zdApleHQ0ZnNfaW5kaXIyX2Jsb2NrW3Ji
bG9jayAvIHBlcmJsb2NrX2NoaWxkXSwgd2l0aG91dCB0aGUgbW9kdWxvLgoKRm9yIGEgZmlsZSBi
bG9jayByZWFjaGVkIHRocm91Z2ggdGhlIHNlY29uZCBvciBhIGxhdGVyIGVudHJ5IG9mIHRoZQp0
cmlwbGUgaW5kaXJlY3QgYmxvY2sgKHJibG9jayA+PSAoYmxrc3ogLyA0KSAqIChibGtzeiAvIDQp
KSwKcmJsb2NrIC8gcGVyYmxvY2tfY2hpbGQgaXMgYXQgbGVhc3QgYmxrc3ogLyA0LCBzbyB0aGUg
Y29tcGFyZSByZWFkcwpwYXN0IHRoZSBlbmQgb2YgdGhlIGJsa3N6LWJ5dGUgZXh0NGZzX2luZGly
Ml9ibG9jayBidWZmZXIgYW5kIGNhbgptYWtlIHRoZSBsb29rdXAgcmV1c2UgdGhlIHdyb25nIGNh
Y2hlZCBibG9jay4KClVzZSB0aGUgc2FtZSBpbmRleCBmb3IgdGhlIGNvbXBhcmUgYXMgZm9yIHRo
ZSByZWFkLgoKU2lnbmVkLW9mZi1ieTogQW5hIEJvYmlsbG8gPGFuYWJvYmlsbG8zQGdtYWlsLmNv
bT4KLS0tCiBmcy9leHQ0L2V4dDRfY29tbW9uLmMgfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9leHQ0L2V4
dDRfY29tbW9uLmMgYi9mcy9leHQ0L2V4dDRfY29tbW9uLmMKaW5kZXggM2FhYjFjODcyMzMuLmNm
ZjExMmZiOTliIDEwMDY0NAotLS0gYS9mcy9leHQ0L2V4dDRfY29tbW9uLmMKKysrIGIvZnMvZXh0
NC9leHQ0X2NvbW1vbi5jCkBAIC0yMDA4LDkgKzIwMDgsOSBAQCBsb25nIGludCByZWFkX2FsbG9j
YXRlZF9ibG9jayhzdHJ1Y3QgZXh0Ml9pbm9kZSAqaW5vZGUsIGludCBmaWxlYmxvY2ssCiAJCQl9
CiAJCQlleHQ0ZnNfaW5kaXIzX3NpemUgPSBibGtzejsKIAkJfQotCQlpZiAoKGxlMzJfdG9fY3B1
KGV4dDRmc19pbmRpcjJfYmxvY2tbcmJsb2NrCi0JCQkJCQkgICAgICAgLwotCQkJCQkJICAgICAg
IHBlcmJsb2NrX2NoaWxkXSkgPDwKKwkJaWYgKChsZTMyX3RvX2NwdShleHQ0ZnNfaW5kaXIyX2Js
b2NrWyhyYmxvY2sgLworCQkJCQkJICAgICAgcGVyYmxvY2tfY2hpbGQpICUKKwkJCQkJCSAgICAg
KGJsa3N6IC8gNCldKSA8PAogCQkgICAgIGxvZzJfYmxrc3opICE9IGV4dDRmc19pbmRpcjNfYmxr
bm8pIHsKIAkJCXN0YXR1cyA9CiAJCQkgICAgZXh0NGZzX2RldnJlYWQoKGxiYWludF90KWxlMzJf
dG9fY3B1Cg==
--00000000000007e61b065e7a176f--
