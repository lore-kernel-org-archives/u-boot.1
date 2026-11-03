Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81722606A329
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fEcyNS+D;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=VI+caq+x
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5ECDF80D49;
	Tue,  3 Nov 2026 17:20:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wnf58jTf9HOV; Tue,  3 Nov 2026 17:20:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 976FF80CA6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793726449;
	b=r9tlOLXxU05HZR394vv7Vd4hTRYmAqonDv2Gip6CVhaE6XaL1r2QY5WsurcKjyTi9TwC
	 ot1AXIZCJwc0swn3QANiZIeZAUbrIxNw3/b4sven3PLIWPWC05wV+qou5jZ3DOGWJyVu6
	 IQHJ+EEVf9y1hZKqWKJIG2xF0gwlY+2GaibSqP894sqMmhf9HC6tSB0CGHbSiyqz4fnB4
	 i1ziloDHnZucvVToZ3kSoOrtAvSXIO4JNr6pkGJeIxzV4Sd6UkLpCrUNi56J3CSTm3Pow
	 4DnZAHW8eBkRE6dxs4oRfmC3pujjLOm/NbwFisvEdcsYRm5KlFITh6di/hFdpZZV92w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793726449;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bz7+CjBulW9louJ1thgzJk/YBJNk5KWRtRaM/QJ52wk=;
	b=hjxR3PeJ/dJ+Rqosq7Y1BvGjujWzAbIJHILsce+vI9Cudz240r9MVLK/zDj+5iWtwLbn
	 FPPnEV268rmXU98LXraLGo52RCTUQjXBeb+g5AkTNstJdlv4wNjEuHXxuOIVxAAVSK6hx
	 S6QSHfNOpRRXLVfnWD4do+KdmMdKqm1eWT6VEn0NOKy+QS3iEvmlIB5HKTsdGnhifKFiQ
	 ov700sr3mDTmbB0YdOeeA2MCCJMMLgpj8p2ExgEsfh66UdKCBtXheagVO3c8+dBt2h0Lr
	 c/ZmAJeRyWZYSBiKcqPmULaMZpyWLQvAdHzLlJ45cKu354JNJnr2fqWQmqikgCS8DCQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793726449;
	bh=bz7+CjBulW9louJ1thgzJk/YBJNk5KWRtRaM/QJ52wk=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fEcyNS+D+HOPVBffOI8cL6Tv8g4QYwYcAp44BE/cRCEaRgLrfCsWwGo+ISqMvkQjG
	 GVuJR44vPxymzSgzcRzUCmLOKqPueZn0dGYeLymjJTUXf8u31V9GuGIYwNx4wpXhp8
	 P1uX1p/+v1B8AqU6NXVNdEXbZFUYQQy9JwXvOT19sdHdXWM4oLs4i9KsVOmuexq7bV
	 h6koKaicsz6fFPUoOsP9KPTO/nSPE9f24vuRcxjhS3q4tD7m/Bg4rSVwpmoYsIfLua
	 bDwpRKNozGSJ3VhkWQu4PAa7DvUgyyhlIXB/R5CaMVr/g/EBJzVsipi+K8lTUvNI7X
	 NU0V++GZtOAdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 976FF80CA6;
	Tue,  3 Nov 2026 17:20:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DDD422B6
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 17:20:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C3E8040068
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 17:20:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g5CSKzgR9lCf for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 17:20:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0A82440062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793726448;
 b=lCy0vFlG90i8g3sQ+U7INPfxO7Jd8GxC4seJc3vAc8C7CqFBEZ3o01jr3/JEEd319k5O
 Lnc7IciPdwBm0peGr5sm3DGJz6OiUCXePUzLHreuETks5OSfR3pN0oTaRW8tyJnALr5ub
 mKUXk8WEAJpCeRuUtYQQfj10ueNcsPCPAlQiR43aM85Zc2HkiuxMVk1Z0AHcF0cHuHvQV
 xViAcf0wgeWi739l1ulFjORlLn05r33hSYYdm2A4iCMTVDabdFXUSWGyJ7FieOtyfuTnl
 EUFoNujQMss2OjbndRoN603EO6nS5QNbFrKMumXqzPh86tmOmn0IGyCoCuls93NmFKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793726448;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Subject:
 Message-ID:MIME-Version:Content-Type:Content-Disposition:
 X-Clacks-Overhead;
 bh=bz7+CjBulW9louJ1thgzJk/YBJNk5KWRtRaM/QJ52wk=;
 b=cYUqz/QH7DRmfuBxTqIo5rlJWuQMyCPwsGjNQYEF3AhX7ewhJQLclzYkpTErfZykLN1S
 UTjOsEeEEOduoWSuESCkEZ88VsawwS8aN3ARIHqvyNlrxJYdlrM+FeYrnAh+mZPi+s/Dt
 2daXE7EUMMHKV5s4phy3cKAjJKZgqYw049YZ/NMOQU/FgyMGm2nyMBrT0st22uEV/3oyf
 jlqxM5UO7R2npvymH9AV9LR+O3Qrvn/ka/gd1v0ZhWWp5gb4Q1OWTONzaAyYairlvr/2N
 IGNPuQ1wZeusbyevdSncxofAPpB9RAacDxsQLAO8OMhhhi4n/35pnrh75OLf3zITCoQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VI+caq+x; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VI+caq+x
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0A82440062
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 17:20:47 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-85d363fb73cso2530160a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 09:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793726447; x=1794331247;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:to
 :from:date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bz7+CjBulW9louJ1thgzJk/YBJNk5KWRtRaM/QJ52wk=;
 b=VI+caq+xXPVfnBflrkaIvtahEAGepyUF0H5SAjVo5AEnHklUn+xw4nUwSdXBSxbyVH
 rTBIIYI3LKtqxrN2Z6F+wYpKasLUWaklKSx+4mNbtC9h3jyyq0Gvm0TFdQ+1UMhVbTCq
 g27Eno8i15y6XtKq2lJQs/U7/w1xe6Ir7Z+nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793726447; x=1794331247;
 h=content-disposition:content-type:mime-version:message-id:subject:to
 :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bz7+CjBulW9louJ1thgzJk/YBJNk5KWRtRaM/QJ52wk=;
 b=EXAyietAxn1Z1Pyz53FME+oKuUp8AibxaSLHFEGNkWsxN4TWEgQIDr2gMVAfk9/5rG
 E28rUb8GEmDFyeXQoMy58oJgRyLb3TU7WfShX+6Gatb7u4jV0zBxSiIE26Wfr8M60HAZ
 wGFHD4lxfTAQKbfhdQ6T2WrhaXNpSf1tpvNGp0Pt09cxLBQvepog/1kyEPkWC4k5K/sY
 lXeROn7S0JLBreVML/TTpeqV9KksBtU+CAqjelk9d45K+V09q1GcirxFBcpee+pvDspK
 avaFhNHaZMrpfovCaxbkOpH7zdiSBraVnTor6Fh2kxf7NQdCPCG5/gXAB/B4WwZhfSYd
 G4hA==
X-Gm-Message-State: APuU4Z84mqDcy80rGhF0gjX/WFNj2IdRDwWrrpSDds+sB80n5nDAnMb6
 O5+c19sJIIJmgej5ICkePjg4QMHXKJJ9RssQY8zLpthSoo/qgPdFcbnLBQmuJxOlVlALli2vD3g
 +ewwgoXTt1PsG
X-Gm-Gg: AYBFou1gncxOrQd8yX5y+AzoWVCRR0uIXVZOd4tMEPGXnLh2vIH7fmxj02vEmJ65kvI
 55WsnJ3B5kHGhG8P9/HRXGUkmM0exkh8KXO9/EWrWIHbpPnE+ZjO64NCDtQnVrpbErGPlilEVl7
 WZpKzcEkLCaUWaWYRrlMJSLfXDyig1qwIsEjrNt7t4ATp8YqAiZ2LWyXCz1BKOplahxCk1cbuzJ
 IiluuV1HphzN7wSbm/pbAMPzn+XRlVGbqgwmie3eYeJt1xBiVrihETKlOm7YtRPH05fCOHkXzfW
 OQy5XdSvhrlPWam3zkFJw15odxA3XQjvfEIhwSGes+LEFW/Tk1NfmBJPb0Tclv6bGe5xEwdH15I
 nl0m5aObl2xn7seUl9jSTni4Y5fttFqga+4D91E0fQ/93SxUaVgfx78B9McVVLBoszH9RDcJrvs
 H/Kg98Vjuz9qJeUcA+kYBbVsW/02gDTeNswszD432tQVShjxtGw1ZjbbxSAF7aZKqKxounu6hSX
 cUvblMuK7cAgCan3V2VebRM6SqldVbo5/7OwMVUyHYaCWULdPrXbDWt55yJacsrZuSKL6H8ciwK
 /qg9oQaNj4kO1/SoE7K67B02q8WnZTtXrycugTzghztfXa4LbU9MwwEzhHgEV9pH9N2ndPXWehs
 de1XFuQXSEl30L9igQVuhC+oBumHSCe9vdrUACvsirRQ1SJVsCR1shA3e6mmRotU09QDjei5hJl
 DvA2IuOYP6iiPb0xQoOSCOtVerBlTZug==
X-Received: by 2002:a05:6830:4116:b0:81c:4784:a5e2 with SMTP id
 46e09a7af769-85d3634481amr9890742a34.6.1793726446643; 
 Tue, 03 Nov 2026 09:20:46 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d3501abc9sm12280331a34.0.2026.11.03.09.20.45
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 09:20:46 -0800 (PST)
Date: Tue, 3 Nov 2026 11:20:44 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [RFH] Adopting a Technical Steering Committee (TSC) structure
Message-ID: <20261103172044.GT3309461@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="szbt/oRi0OJOZxwG"
Content-Disposition: inline
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--szbt/oRi0OJOZxwG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Getting back on track with project administrative tasks, another thing I
have talked about the project needing for some time is adopting a
Technical Steering Committee (TSC) model so that for contentious issues
there is a way for the community to have a group of trusted members make
a decision for the project as a whole. So, I'm looking for examples of
this structure in other open source projects that people feel would be a
good example for us to look at. Thanks!

--=20
Tom

--szbt/oRi0OJOZxwG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauoX7AAKCRAr4qD1Cr/k
CshgAQD5E1/BNjgX4Y+9+wLF/IAuWWO9uFdztrRchqjp1SaF8QD/RbPplxblFoVD
Qwb5ylkrn216JMu1xjYRoZFddcighw0=
=AmW+
-----END PGP SIGNATURE-----

--szbt/oRi0OJOZxwG--
