Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A942C43458
	for <u-boot@archiver.kernel.org>; Sat, 11 Jul 2026 02:28:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD6EE84AE8;
	Sat, 11 Jul 2026 04:28:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VCCQ3sVq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70BCE84AC3; Sat, 11 Jul 2026 03:43:01 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CAD584A92
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 03:42:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=7991aleschino@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-69c600f76ccso413367a12.0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 18:42:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783734178; cv=none;
 d=google.com; s=arc-20260327;
 b=qFIV9ltggrOMP9Rfu2HGzzeRtNtdRl5rfS2wHWqcGF5r4/cwwr+G46iiaGvW0tvLb+
 xyZ7Fd8V1vXTD7eNGJ6YyV6YbQpK25gLs+/byutuTWU0L9HxdPlk4zwA5JVcG3Al3tLT
 2+B7tl8oM654rLdv9X02h5ItKZ19fNcfF4qlR/zdDwHaw3UWME6CCZ1Asi8FBBGSQiCs
 Wij7MOW/MV/QZz20JweuexrXXQqcF9w4Sc0WULWeuMrCnLacakf5+MR3PqW4CSjQOAp/
 sZSIK9HsYqc8+v2BYQ8os4EbIMsmIvUIK8yXH0G0GLp2Ic3XrWTjc+9hWtDdnkXMfUQ+
 kdlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=O6VPot/gmW3p/eHsCaAqXZsDwcwjvvOducKzTWnHreA=;
 fh=ea3Lb1kmqTyoSSOGd3r79PdCdfQHXBjS15GzGXd6hwE=;
 b=oZ4YRvFDRE46STShK1XwBIXepkL61zWwUXr4JNQrF1y2j90ZtN4OnTUez8lnNPQ+q4
 JfGjagcJ1dEEBvvix4/VW2Up8I1+GzKZY5L6uvWKva/LeMyzYbYJ7RNfe4Tf7cH40sQJ
 a3nbtpumpME4w4W+6OVOBuwfP9JMRMtMgwrX8KNAT/fzEo/1GeWeD/8b5w9tyiV8rgls
 5iWD2AMuIQeF0QkJ+Hpo//FWn04mHu5dM2dTYZIb1NOhuhRE/94q+Ooo/T0v1Ws7Ss0m
 DtqoatbGIHa1XrbJpl6fVDT8vcXsq+85huUEU9P1z3Jr+x2uG5SUE3+qTqPNrZEv04We
 cl1g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783734178; x=1784338978; darn=lists.denx.de;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=O6VPot/gmW3p/eHsCaAqXZsDwcwjvvOducKzTWnHreA=;
 b=VCCQ3sVqCfjtC1/uF0Mbfu9RNuzX/jZGCBO5J69LyiYtbhOIIyigyfySfHR9TJN+dV
 jN4mUTKIq6bUgWodf0/gYPzcTlrStEURKDU2ZByERtGE1F5amoxSrAQU3E0DrcEsCwA6
 91csM2NPJl/44rwwFAeQmeCk6Au+7DUTKksdQLsVuZpIgEYZOIGL8F1NSbJ4z4Zw9uot
 k8MVckPbwye+rrVdftg8v7K9GZinBBjh345UEUSW2+819GAQB5IzawLEaPCRZEuWkd1a
 I+vZJWCxxTZSnZKUbgUaklDOQNGrtMV82TXaA+xJ5MA+39ojl4zRjA6JrKipUYkcS2xu
 9pGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783734178; x=1784338978;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O6VPot/gmW3p/eHsCaAqXZsDwcwjvvOducKzTWnHreA=;
 b=A8jNgHdiAnjjZjNLqzXOKG7RsGze3CxKnS/OPJ1m14tYBSlrZ8XHTOsiAhqHhpTjNP
 AKAjyTEBwbE9CmOB63JNDXU3iRlyeNF0WIDvXcpUsA9M4fN2TVrlqEulWI/bA1kphEiA
 m4BUjKl6AztNQ2iojzZMM6HigP95hr9CXH+ZYHL0XLU2eYzdKRrM5vcp7ARocNT5Gs4g
 RchDajBIzs363C5LkAwDfmOOVsGDj/0455rWt2Rwby38F28yJO72UvatWV/I3/zHIxDA
 UO61m+KrvEurXecOATJ/XVwcpRcnAlr2zG2lWk2r1KuBKJez4UZJ3moNtSqdbdpyHeSn
 BSoA==
X-Gm-Message-State: AOJu0YzQ7iWkK2ke3baENvmAg90OFnmtRWHM9juxkhi+Wl2TfaIJCkJ3
 eDNunQn5P8Zd7WrJRfth8t0dVP2ai01IhPpzasWKfQG7FJXur3p6d6VgQpMqZm6CsVIYvYweKzL
 acD8zCCNnpXOXy3UFqxOr9hqyw45CvNN29A==
X-Gm-Gg: AfdE7ck7N/dKo56lAHVy/kem3jmx1thLd+H/XjXCA0iUouZUujFVx4d414wAKzOzlIW
 /nwFyQw0AKoQKvlIICP7rb+ymedbefdlNBrKGTJ4khBRS2sujphGMAwW9VrInXJi8lRnLpvuTHg
 CcOgxTIjaZkw4rgvkHG78EWI5amndisU8VMAG589Ub0FFd5G2OZSLEadkyjBZiZK3D6ON5QPAXk
 pVFSnmQLN+cy6tLI3JgPMM/6hO/Rylztzp+bMnrwJdbibbKNLDGm34mrJu4DMiEWcP9bxDnQBR5
 xmtK+LyLGfiLO0ODIKhFJbAWJWA=
X-Received: by 2002:a05:6402:1f84:b0:69c:3ea3:6d39 with SMTP id
 4fb4d7f45d1cf-69c5f230794mr659935a12.35.1783734178438; Fri, 10 Jul 2026
 18:42:58 -0700 (PDT)
MIME-Version: 1.0
From: Alessandro Schino <7991aleschino@gmail.com>
Date: Sat, 11 Jul 2026 03:42:47 +0200
X-Gm-Features: AUfX_mynr2Q53RDVTwi4ZOUgz48PznUY1OSAIz4nqvHeTC5ChPotMIJHJ6yBrxU
Message-ID: <CABNe9nNJGCLL1jnDJvDBEBufAYH+vuY54xzz=EMh_YGUjjw5Ew@mail.gmail.com>
Subject: [SECURITY] Out-of-bounds read in btrfs driver (btrfs_read_extent_reg,
 fs/btrfs/inode.c)
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Sat, 11 Jul 2026 04:28:37 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hello,
I'm reporting an out-of-bounds read I found in U-Boot's btrfs filesystem
driver while reviewing the source, and confirmed with a working
AddressSanitizer reproducer on a sandbox build.
Summary
In btrfs_read_extent_reg() (fs/btrfs/inode.c), the compressed-extent path
uses file_extent_offset =E2=80=94 a value read directly from the on-disk ex=
tent
item =E2=80=94 as an offset into the decompression buffer, without validati=
ng it
against the buffer size (ram_bytes). A crafted btrfs image with a large
file_extent_offset makes the subsequent memcpy read far past the end of the
buffer.
The two ASSERT() guards earlier in the function do not prevent this:
U-Boot's assert() is compiled out when _DEBUG is unset (the production
default), and the asserts do not compare file_extent_offset against
ram_bytes anyway. U-Boot also does not import btrfs's semantic
tree-checker, so the field is not validated at leaf-load time.
Impact
Out-of-bounds read reachable from an untrusted btrfs image (e.g. removable
media). The out-of-bounds bytes are copied into the read destination
(information disclosure); depending on layout the read can also fault
(denial of service during boot). As this runs in the bootloader, the usual
runtime mitigations are absent.
Reproduction and full details
I confirmed the crash on a sandbox build with CONFIG_ASAN: loading a
crafted image triggers an AddressSanitizer READ overflow in memcpy, called
from btrfs_read_extent_reg. I tested against commit 6741b0dfb41 .
A complete technical writeup, the PoC generator, and the AddressSanitizer
output are available here:
https://github.com/inkman97/U-Boot-btrfs-oob
The writeup also includes a suggested bounds check and a broader
recommendation to validate btrfs_file_extent_item fields at leaf-load time.
I'm following coordinated disclosure and happy to work with you on timing
and testing. Please let me know your preferred channel if you'd rather I
share the material privately.

Best regards,
Alessandro Schino
