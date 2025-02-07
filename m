Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB79C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 19:06:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB471801BE;
	Fri,  7 Feb 2025 20:06:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RBkFtu8F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FD1F80207; Fri,  7 Feb 2025 18:53:17 +0100 (CET)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D04C5800B3
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 18:53:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jonathanbaror@gmail.com
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4ba86dee27bso375610137.3
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 09:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738950793; x=1739555593; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GZ9oGT4s6MgoPPAQ8H4EpzhDWftqJmGVe81Q5H8XyA8=;
 b=RBkFtu8FqLHzaM7Mkq4A7Q+LQeYUhBu6wPyjHfcOZwvRZaNqNw+IH8jYORTp+tW9tq
 Oh/g1W/tzmb6fWX6XPpHFGuiQick8mTLa254Ezrz6LZ23wmpJyQDuGA3UteEcYWonjT3
 E2LocXdCDRWWhDkr8XJoW9Eq0Qlr+yvCftMc2bboW+SrVj//pFR9udGv0ZFffJpEnLpX
 OdLnzqmYPCcoojdjhCzOfKHxc8KO+pdCrUSv/xqCXpTMVQ5d86PmSB+F0KuOHVTodS0O
 ivOePl2+rIcG/aKfDGbOWagIEK+9AUxhatuMtQFZTuooHPimoWQCzxy0bgCfdjDTOKID
 koPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738950793; x=1739555593;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GZ9oGT4s6MgoPPAQ8H4EpzhDWftqJmGVe81Q5H8XyA8=;
 b=IOftsvPc+ObRQblRqIzvAWtRDZ05ibAzPs1NYuNwWx7nK2E7Wrrtk/e0Mb0jFjD08E
 tiJT/HFVOus7BbkcI6ggWruHOr33+PJkIMQxy07S0JF391g12Vg8GccjhpL9kLBX/IXW
 1sVkZikkftw6Ibd+sVac9k761WIS/CVipjGvh/Nbh0WjP8xFBrv+T7JenyvOqbFwhION
 qoLv0Y6WEx8KmQqEWk+WJ5khMVnfacqpAEGE2/KvJl+56U5YxyddJluASBb2WpKfNoFA
 b6PKIgjg9uTMymOmGG/rg4/EGa+jjHgpqyMsqThXork4n7UTfMIIba+ixCqxxBImTEqJ
 IaKg==
X-Gm-Message-State: AOJu0YzDHLZnR/AyF5eGJfbAtjDqqBoLq/DLvuI663mHGRL3Gfr92rZl
 Q2uDlj3nO+EzIX2liMiE6wUTnMugFOeKWRqlNuBgRl+p+DJQ8y7WhHStZkuPOLcBf5z6zFMRn2U
 g1KgJ/kbM5QqH5rCzPU3KeW5F4H+Lqsi4xtg=
X-Gm-Gg: ASbGncvedfetjCAJ6jigSsefV06MzvC/Aw5VOaLDPQUJbrSENL/RVnoYZ6rOnrl4U1m
 u+vXuOhsbbgtll9GVq5B/pyUWRtLgeV8HluQgc+/wPaK/AHF+1CAnBulnCtSqdb610OvzCRw8Pg
 pJ3CHNyM1JLGi/s7Vxx2SeGpO1JQ6B
X-Google-Smtp-Source: AGHT+IEjKGWpUYyJCrwVmL5dhxRG0/IBPCVxG0mHpA66rHf1cAB7g2htfx8EgCMvTsTddLkY9HaGI3Gjy9DBVEwQKfU=
X-Received: by 2002:a05:6102:578d:b0:4b1:340a:ce63 with SMTP id
 ada2fe7eead31-4ba85e3dae8mr3829499137.11.1738950793566; Fri, 07 Feb 2025
 09:53:13 -0800 (PST)
MIME-Version: 1.0
References: <CABMsoEGyEgWGHYMoL9kH2Os_=krqSTwdLaMu+XSOJd+micYpGQ@mail.gmail.com>
 <20250207155048.GX1233568@bill-the-cat>
In-Reply-To: <20250207155048.GX1233568@bill-the-cat>
From: Jonathan Bar Or <jonathanbaror@gmail.com>
Date: Fri, 7 Feb 2025 09:53:01 -0800
X-Gm-Features: AWEUYZmG_nIH6lI_lnONzGQIVgWde4gHGN3eqP4HBojItPAJ1mHkJEc4Og_9aj8
Message-ID: <CABMsoEGLaMGch7gEuGGcyPy5REj4RDAFmX=AGnOmMnnbuSmhWA@mail.gmail.com>
Subject: Re: Security vulnerabilities report to Das-U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: multipart/mixed; boundary="000000000000553ac4062d9108c4"
X-Mailman-Approved-At: Fri, 07 Feb 2025 20:06:26 +0100
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--000000000000553ac4062d9108c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you.

So, I'm attaching my findings in a md file - see attachment.
All of those could be avoided by using safe math, such as
__builtin_mul_overflow and __builtin_add_overflow, which are used in some
modules in Das-U-Boot.
There are many cases where seemingly unsafe addition and multiplication can
cause integer overflows, but not all are exploitable - I believe the ones I
report here are.

Let me know your thoughts.

Best regards,
            Jonathan

On Fri, Feb 7, 2025 at 7:50=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote:

> On Thu, Feb 06, 2025 at 07:47:54PM -0800, Jonathan Bar Or wrote:
>
> > Dear U-boot maintainers,
> >
> > What is the best way of reporting security vulnerabilities (memory
> > corruption issues) to Das-U-Boot? Is there a PGP key I should be using?
> > I have 4 issues that I think are worth fixing (with very easy fixes).
> >
> > Best regards,
> >             Jonathan
>
> Hey. As per https://docs.u-boot.org/en/latest/develop/security.html
> please post them to the list in public. If you have possible solutions
> for them as well that's even better. Thanks!
>
> --
> Tom
>

--000000000000553ac4062d9108c4
Content-Type: text/markdown; charset="US-ASCII"; name="notes.md"
Content-Disposition: attachment; filename="notes.md"
Content-Transfer-Encoding: base64
Content-ID: <f_m6v2ap430>
X-Attachment-Id: f_m6v2ap430

RmlsZXN5c3RlbS1iYXNlZCBEYXMtVS1Cb290IGlzc3Vlcy4KCj09IGVyb2ZzCgo9PT0gSW50ZWdl
ciBvdmVyZmxvdyBsZWFkaW5nIHRvIGJ1ZmZlciBvdmVyZmxvdyBpbiBzeW1saW5rIHJlc29sdXRp
b24KSW4gZmlsZSBgZnMuY2AsIHdoZW4gcmVzb2x2aW5nIHN5bWxpbmtzLCB0aGUgZnVuY3Rpb24g
YGVyb2ZzX29mZl90YCBnZXRzIGFuIGBlcm9mc19pbm9kZWAgYXJndW1lbnQgYW5kIHBlcmZvcm1z
IGEgbG9va3VwIG9uIHRoZSBzeW1saW5rLiAgClRoZSBmdW5jdGlvbiBibGluZGx5IHRydXN0cyB0
aGUgYGlfc2l6ZWAgbWVtYmVyIG9mIHRoZSBpbnB1dCBhcyBzdWNoOgoKYGBgYwogICAgc2l6ZV90
IGxlbiA9IHZpLT5pX3NpemU7CgljaGFyICp0YXJnZXQ7CglpbnQgZXJyOwoKCXRhcmdldCA9IG1h
bGxvYyhsZW4gKyAxKTsKCWlmICghdGFyZ2V0KQoJCXJldHVybiAtRU5PTUVNOwoJdGFyZ2V0W2xl
bl0gPSAnXDAnOwoKCWVyciA9IGVyb2ZzX3ByZWFkKHZpLCB0YXJnZXQsIGxlbiwgMCk7CglpZiAo
ZXJyKQoJCWdvdG8gZXJyX291dDsKYGBgCgpUaGUgYGVyb2ZzX2lub2RlYCBzdHJ1Y3R1cmUncyBg
aV9zaXplYCBtZW1iZXIgaXMgZGVmaW5lZCB3aXRoIHRoZSB0eXBlIGBlcm9mc19vZmZfdGAgKHdo
aWNoIGlzIGEgNjQtYml0IHVuc2lnbmVkIGludGVnZXIpLiAgClRoZXJlb2ZyZSwgaWYgc3VwcGxp
ZWQgYXMgMHhGRkZGRkZGRkZGRkZGRkZGLCB0aGUgYGxlbiArIDFgIGlucHV0IHRvIGBtYWxsb2Ng
IHdvdWxkIG92ZXJmbG93IHRvIDAsIGFsbG9jYXRpbmcgYSBjaHVuayB3aXRoIDAuICAKVGhhdCBj
aHVuayAoc2F2ZWQgaW4gYHRhcmdldGApIGlzIGxhdGVyIHdyaXR0ZW4gd2l0aCBgZXJvZnNfcHJl
YWRgLCBvdmVycmlkaW5nIHRoZSBjaHVuayB3aXRoIHBhcnRpYWwgZGF0YSBjb250cm9sbGVkIGJ5
IGFuIGF0dGFja2VyLiAgClRoZXJlZm9yZSwgd2Ugd2lsbCBoYXZlIGEgaGVhcCBidWZmZXIgb3Zl
cmZsb3cgZHVlIHRvIGFuIGludGVnZXIgb3ZlcmZsb3cgaW4gYGxlbmAgY2FsY3VsYXRpb24uCgo9
PSBzcXVhc2hmcwoKPT09IEludGVnZXIgb3ZlcmZsb3cgbGVhZGluZyB0byBidWZmZXIgb3ZlcmZs
b3cgaW4gaW5vZGUgdGFibGUgcGFyc2luZyAKSW4gZmlsZSBgc3Fmcy5jYCwgZnVuY3Rpb24gYHNx
ZnNfcmVhZF9pbm9kZV90YWJsZWAgaXMgcmVzcG9uc2libGUgb2YgcmVhZGluZyBhbiBpbm9kZSB0
YWJsZS4gIApJdCBnZXRzIHRoZSBzdXBlcmJsb2NrIChhdHRhY2tlciBjb250cm9sbGVkKSBmcm9t
IHRoZSBjb250ZXh0LiBUaGVuLCBpdCBlbXBsb3lzIHRoZSBmb2xsb3dpbmcgbG9naWM6CgpgYGBj
CiAgICBuX2Jsa3MgPSBzcWZzX2NhbGNfbl9ibGtzKHNibGstPmlub2RlX3RhYmxlX3N0YXJ0LCBz
YmxrLT5kaXJlY3RvcnlfdGFibGVfc3RhcnQsICZ0YWJsZV9vZmZzZXQpOwoKCS8qIEFsbG9jYXRl
IGEgcHJvcGVyIHNpemVkIGJ1ZmZlciAoaXRiKSB0byBzdG9yZSB0aGUgaW5vZGUgdGFibGUgKi8K
CWl0YiA9IG1hbGxvY19jYWNoZV9hbGlnbmVkKG5fYmxrcyAqIGN0eHQuY3VyX2Rldi0+Ymxrc3op
OwoJaWYgKCFpdGIpCgkJcmV0dXJuIC1FTk9NRU07CgoJaWYgKHNxZnNfZGlza19yZWFkKHN0YXJ0
LCBuX2Jsa3MsIGl0YikgPCAwKSB7CgkJcmV0ID0gLUVJTlZBTDsKCQlnb3RvIGZyZWVfaXRiOwoJ
fQpgYGAKCj09PSBJbnRlZ2VyIG92ZXJmbG93IGxlYWRpbmcgdG8gYnVmZmVyIG92ZXJmbG93IGlu
IGRpcmVjdG9yeSB0YWJsZSBwYXJzaW5nClNpbWlsYXJseSB0byB0aGUgcHJldmlvdXMgaXNzdWUg
aW4gaW5vZGUgdGFibGUgcGFyc2luZyBpbiBgc3Fmcy5jYCwgdGhlIHNhbWUgdW5zYWZlIG11bHRp
cGxpY2F0aW9uIGV4aXN0cyB3aXRoaW4gdGhlIGZ1bmN0aW9uIGBzcWZzX3JlYWRfZGlyZWN0b3J5
X3RhYmxlYCByZXNwb25zaWJsZSBmb3IgcmVhZGluZyB0aGUgZGlyZWN0b3J5IHRhYmxlOgoKYGBg
YwogICAgbl9ibGtzID0gc3Fmc19jYWxjX25fYmxrcyhzYmxrLT5kaXJlY3RvcnlfdGFibGVfc3Rh
cnQsCgkJCQkgIHNibGstPmZyYWdtZW50X3RhYmxlX3N0YXJ0LCAmdGFibGVfb2Zmc2V0KTsKCgkv
KiBBbGxvY2F0ZSBhIHByb3BlciBzaXplZCBidWZmZXIgKGR0YikgdG8gc3RvcmUgdGhlIGRpcmVj
dG9yeSB0YWJsZSAqLwoJZHRiID0gbWFsbG9jX2NhY2hlX2FsaWduZWQobl9ibGtzICogY3R4dC5j
dXJfZGV2LT5ibGtzeik7CglpZiAoIWR0YikKCQlyZXR1cm4gLUVOT01FTTsKCglpZiAoc3Fmc19k
aXNrX3JlYWQoc3RhcnQsIG5fYmxrcywgZHRiKSA8IDApCgkJZ290byBvdXQ7CmBgYAoKVGhlIG11
bHRpcGxpY2F0aW9uIG9mIGBuX2Jsa3NgIGFuZCB0aGUgYmxvY2sgc2l6ZSAoYXR0YWNrZXItY29u
dHJvbGxlZCA2NC1iaXQgdW5zaWduZWQgaW50ZWdlcikgaXMgdW5zYWZlIGFuZCBtaWdodCBvdmVy
ZmxvdywgcmVzdWx0aW5nIGluIGFuIG91dC1vZi1ib3VuZHMgd3JpdGUuCgo9PT0gSW50ZWdlciBv
dmVyZmxvdyBsZWFkaW5nIHRvIGJ1ZmZlciBvdmVyZmxvdyBpbiBuZXN0ZWQgZmlsZSByZWFkaW5n
ClNpbWlsYXJseSB0byB0aGUgcHJldmlvdXMgaXNzdWUgaW4gaW5vZGUgdGFibGUgcGFyc2luZyBp
biBgc3Fmcy5jYCwgdGhlIHNhbWUgdW5zYWZlIG11bHRpcGxpY2F0aW9uIGV4aXN0cyB3aXRoaW4g
dGhlIGZ1bmN0aW9uIGBzcWZzX3JlYWRfbmVzdGAgcmVzcG9uc2libGUgZm9yIHJlYWRpbmcgYSBm
aWxlOgoKYGBgYwoJCQlkYXRhX2J1ZmZlciA9IG1hbGxvY19jYWNoZV9hbGlnbmVkKG5fYmxrcyAq
IGN0eHQuY3VyX2Rldi0+Ymxrc3opOwoKCQkJaWYgKCFkYXRhX2J1ZmZlcikgewoJCQkJcmV0ID0g
LUVOT01FTTsKCQkJCWdvdG8gb3V0OwoJCQl9CgoJCQlyZXQgPSBzcWZzX2Rpc2tfcmVhZChzdGFy
dCwgbl9ibGtzLCBkYXRhX2J1ZmZlcik7CmBgYAoKQSBzaW1pbGFyIGlzc3VlIGV4aXN0cyBpbiB0
aGUgc2FtZSBmdW5jdGlvbiBhbHNvIGxhdGVyIG9uOgoKYGBgYwogICAgZnJhZ21lbnQgPSBtYWxs
b2NfY2FjaGVfYWxpZ25lZChuX2Jsa3MgKiBjdHh0LmN1cl9kZXYtPmJsa3N6KTsKCglpZiAoIWZy
YWdtZW50KSB7CgkJcmV0ID0gLUVOT01FTTsKCQlnb3RvIG91dDsKCX0KCglyZXQgPSBzcWZzX2Rp
c2tfcmVhZChzdGFydCwgbl9ibGtzLCBmcmFnbWVudCk7CglpZiAocmV0IDwgMCkKCQlnb3RvIG91
dDsKYGBgCgo=
--000000000000553ac4062d9108c4--
