Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28312CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 17:15:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB88C405F6;
	Mon, 28 Sep 2026 17:15:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GD7Ca9xowsjE; Mon, 28 Sep 2026 17:15:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D5A93405EF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790615729;
	b=rDThfNRHeduc3VR0Unp2rYwznIlmT5y/4M5wcTmBjWXrTWSvUmU060RFMniNpIAfNjZt
	 a9BuT5zp/eMbKx5EPIP7QTv3weZsNk/Qno4h4H93Z137KtY6I41ifNvLmDboiR+Vg+7/c
	 r7KRzV7Fd/zR/Iqoz3BZnf1fGT+570Uew7g0bTgngWvZ2aD2QDid4WOPCx16JbdlhYZM6
	 PRIu2wXtG9qNb4WGawqLVVYKq3lQaSaPMMwB055Mwp+Rd8ff5yqEvzQHOzQxt81+Zcubs
	 n8vDgd4PJwBsfap78IHAO0IiplVtvtNrUgvS6yPzmhUP47scJ80UzkpfZCuy5Yj20xA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790615729;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=A+tca33MGbCBzkThS+r08lDzb4geksB/VQhWxmsSSfo=;
	b=YfDMrJHMwyPinOet95dxjLtf7duNONVY8a4+FZ8Ra9OIKK7jNaNz8ev/5LhmVEiqYtWO
	 Sg0oPwVkBd1FYkEmOHPw2jH6rSaq0hGDewH8KoI5D1GO+dlTVMVSYXmfhf4uccFJ2jVGG
	 gkqL2nn0dJKmtKUMHCgqqmyPifr5I517wqIjhuHDrY1D/2hf2WUdhI6RkUHo7DKXi1D/R
	 wKNnuZ5own1HL+PeFoJwZr4jz4OEkrDrl6W4sbgZbC3iRgr82iNqAsCqhDOtBy/SFn68p
	 cFjiBuwQRCkzWa4nbhUkeqCRSOBWA0YhrvtI1A9opI0JTdCxVEor9SD0NMjsI70+zjg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790615729;
	bh=A+tca33MGbCBzkThS+r08lDzb4geksB/VQhWxmsSSfo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qXuWGASocSx9kNWHhhYXO8vnHQY98LdYQkTX6LYLQPGs3UiHEUMSIgz4RhhFfjqm6
	 VNPVYLQXnuejVFe4/V9+0sSkHqV7xbwpbRGBWsy+8Z/+N7gfjjq/PF17dReMiq4hhW
	 +Cf6+inN7tT3F4T34L1SGNz7rJijOm8S1yGsUJMBEoMTqzFypOvifEYt+JP5gsaC8k
	 pghE02sGQTNVNGi27VDYS9g5DdrPOoGWwCHGHZYLGDw09+ZJSqfEcBf8GLbkVGixof
	 Pdb+RiAX/jLy9L2h3d2ps+DqyxzJk62pYfhebMNChPg3eBzG1qhs0mOC96RBXkLXun
	 Hia1AN0QuQioA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5A93405EF;
	Mon, 28 Sep 2026 17:15:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D0BD62B6
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:15:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C224C80DDA
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:15:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AHM6id5CaYAS for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 17:15:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0049280DBA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:3b::2b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790615727;
 b=ZreYZBKBQPKnKSFr1EkFRQ0S/VdR/R35rSPbKd7U+3Y4s/8WMrFX9TSFuFBlW4bCUN2d
 lCzWDERO4OY6YmpMvfarPTb3yisHNfUfW2ISWqWcJsjBwyIQbqx4E0M+/BMk9Ieel4NPL
 g/tF1jO+7PfrRt+Sd1i+jOejrF1/x+p3KQxJ8QKr0SrVyep8qAYb/jSy9+mbhZVbkjtUi
 8WdpEDInEvtxOyAgDsttanyzGxXYg1AhLjGhERfijpL9w7Kmb8tCh7w5Th2HDoacshHHe
 YgaA4tLafeacg8bb2fd1VDkgGHQZnroimsVMRZd4VZnIDX6UdxBLpxEDqzvIvVHEGHw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790615727;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=A+tca33MGbCBzkThS+r08lDzb4geksB/VQhWxmsSSfo=;
 b=J20DiX40zcWEjLYOoVh5OLaJwvM7iqGydWo1p2VP+dM22sO6NV3m5yGcvrlwyS4qYgUX
 ALx4RyBruwFk4DHwyDF7RCzf+4mt+fHt3XJ1QiCD8T6YdChunQFyiNQBFj4zvCbtpshPd
 x/SP1mtgwx5u/Cw4PjtpGyR5+i182hk5JGnfRSnKLQpI00o9Ulh3atpCqdkwP2Kyd47k2
 eFzw6P56fqf8Om5DbqRBAJR3DX611gQVbdkOvCo1P2TySNYNJdgnkcGgcMRG9Z0zjlw3B
 Ncu1F8lGfG332KLgl5RlRWWMin7LuPfSoSyPyVyyAL81S1Z2M1JEYznYjIo35qecLUw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="ktP/BZ/p"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:3b::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:3b::2b; helo=mail-pz2-x2b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ktP/BZ/p
Received: from mail-pz2-x2b.google.com (mail-pz2-x2b.google.com
 [IPv6:2607:f8b0:4864:3b::2b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0049280DBA
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:15:26 +0000 (UTC)
Received: by mail-pz2-x2b.google.com with SMTP id
 41be03b00d2f7-cc78e1a94b8so1858643a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:15:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790615726; cv=none;
 d=google.com; s=arc-20260327;
 b=F6+oq8ZNdaa6n/QCO02HaKVjwVrc0bVp9xRLl5YrSVFuz4QlmvAgqRLHPbCH7ZqMjz
 +uXzllyoD/qOlTJBkrVqYYmH6S6zC42ciqJvapUUZ/jA5+9LHECBHa3jj6bwfS4MiOdu
 61OCONBa9arSMELJbxVhwZNgTVX3LXRtmRFYRj62AZZzlSGDNFz7SDuCOBPlznXj21EI
 ko3/SOYeNTZQ7nLEuSNQMtimzCis94mIiuNvN6lyBUTHWEIgSg5KDJthU3gee71u/7V5
 QBh5lYUuBbKw0kdJHDkDW3bSawKKELO3SiUuMxO+96q/YDY6oRJ4h7XhvG+r08XrItKe
 QP/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=A+tca33MGbCBzkThS+r08lDzb4geksB/VQhWxmsSSfo=;
 fh=QkX7q3bhnh616mELFKGQz0oGtastCVvsdu+QNM1hVcw=;
 b=eLJUjpqPv6IIr/xhm3+eKTcusrzbCIjO/cZtTJEgJOpHLq6LCZAqikXBNab2nF8Zk7
 2OsVoiHp/TUN4UmQiWOzLN2G8panG7LeBCCzDwROPMmLCFVJQUtOKSB0DtoqXrmIzup8
 4koE8Ud/LSbYVSYyjswel9PruqeV3FSFsyGVXhWH0S2Vj0Mbfd8VvTZdg8MjD8N+vjOE
 qqsDHkc1dTGOcrRAoC8kfjdr1nYG1j8CHHcAGiaGFe4FB4SEw+uOGQjknp4Quo7eMK/5
 HRAbHN0/hTdyWJd1yfD/bpUT1QXJJ7wAU3bHks0qsfcgr7pH7vXsP7bRakD7DU3JdLnB
 UoKg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790615726; x=1791220526;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=A+tca33MGbCBzkThS+r08lDzb4geksB/VQhWxmsSSfo=;
 b=ktP/BZ/pwiRHtRtuNDm5gsKKg89wFBJKJ9Au4F9xiLYUMPZn6Ih5bPZ9cg8u7SE4CS
 Nd1n58IXGBOp3kXNN2bvl+ChbRWOnHXDz2HPwJX3oab+gF552BpymGIU8swSOsjhs2J1
 3j/VN1KHoez3vajERnDbiHv8M2HBFGwZP5QDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790615726; x=1791220526;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=A+tca33MGbCBzkThS+r08lDzb4geksB/VQhWxmsSSfo=;
 b=1ncYq89bU/CbnksoS+OS+MgulzEWF9jp7oOJKpqpmlJwjFKxlnijdGa0/uCJkLCF+2
 HVMDoszrjdCX9YNdBFwr7bDmXH0jcGqWQ/iuzC2QxlxQU1bx0MwyaZi2ioq1rHYqI7Gl
 jqu6FY8wR1YCvoCSt+RbQznC5+aUXuXpUXIQNYD6VDxNKTmcaev8oUlYiaxYFk+0ixMI
 qJ6sN8+CoDV9nkPIhhYXW4qaCp2qquhWMKlsK3Tc+LGmgBr/Sgtf8eYXp4PN+JP2bJEG
 ZgxMvGX50lfzJ+ivLYl3RBrB9GsNTeV6DAp/giOXqtBL3LifwAkqFy6woK3UJmscNHQO
 7tNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBycP3h8qQIu+tsEfma8RKWKhlSaYOik0HZiVX+62vMFsSjq61HlV7u7gqAgF9HHu/hn254xeAA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kxXhLuMR9sxL+Tz9b9NR+uiWeOCHPwlAPEa7FZBUJvK/K3/KIx
 /ufd7fbhFrQfXgbkS/E98FHR9Aa4ttPz18U12z1xg2/SxM40mTjoM4ch2cK6qBW5N0mDFNCUPBM
 dc7LABNG53/lMT9DibWXv5kM9ZkRoPUyeo6r6UB69
X-Gm-Gg: AYBFou20pMozB4iXaQxzupa78Kj6yeT/Y5veudtyo7MCwQXVYtpby4iR2c0DI+WtvAA
 og7reMO9Kam5wZVBExOlYSFdWuyuGY1xiZanFfb8+LGC9QjUOEXGC3zuxSReTOpVM+6VzE8dxm8
 F576gNMMTZUSDjQTZ5nvn7N04RxlizBZvq3nIHAMyv2kSs63dX+t8x3aa2benmqO7uB4R2jiu7d
 ysSnt3MOtSx7tXyIdeewQ+sPajLbNzeo1RaFcBNlGAt2xFgvRKqHmpDDWbSRh8egu0P4wi7Zxhg
 /YXgLHhVmRjVS4rA35aV1esZDSMd4WdbZWMt8dqc9R4lKwo+V0d5Zw==
X-Received: by 2002:a05:6a20:a10d:b0:3de:7add:6544 with SMTP id
 adf61e73a8af0-3de7add73a5mr372608637.23.1790615725598; Mon, 28 Sep 2026
 10:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260910081200.679031-1-mwalle@kernel.org>
In-Reply-To: <20260910081200.679031-1-mwalle@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 11:15:09 -0600
X-Gm-Features: AclHuK83MDcXrcuI7Qtt4hJwFRS7zLx-DVvEd8OaDCVbnqOCG3vh_UwwPGBqWN0
Message-ID: <CAFLszTgPpdFFaodn+M6f7rPo7LfWS2s6F3Vea1=V9sC1MeaR8A@mail.gmail.com>
Subject: Re: [PATCH v3] binman: imx9image: respect BINMAN_INDIRS for external
 files
To: mwalle@kernel.org
Cc: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>,
 u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Michael,

On 2026-09-10T08:11:54, Michael Walle <mwalle@kernel.org> wrote:
> binman: imx9image: respect BINMAN_INDIRS for external files
>
> We have the BINMAN_INDIRS for any external binaries, so they don't have
> to be copied into the source/build directory of u-boot. This is
> especially important for image builders like buildroot.
>
> If it is an external binary and if it was not found, use the
> get_input_filename() helper which will also look up the paths in
> BINMAN_INDIRS.

This doesn't match the code: for external files the helper is now used
unconditionally, not only when the file is missing from the output
directory. That is fine (the Makefile passes '-I .' so the output
directory is searched anyway) but please can you update the message to
say what the code actually does.

>
> In the append case, always use that helper as it seems to be only
> handle external files.

Please can you make this definite rather than 'seems to' - the only
users in arch/arm/dts/imx9*-u-boot.dtsi pass AHAB container images,
which are always external. Also 'to be only handle' -> 'to only
handle'.

>
> Signed-off-by: Michael Walle <mwalle@kernel.org>
>
> tools/binman/etype/nxp_imx9image.py | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)

> diff --git a/tools/binman/etype/nxp_imx9image.py b/tools/binman/etype/nxp_imx9image.py
> @@ -51,21 +51,23 @@ class Entry_nxp_imx9image(Entry_mkimage):
> +                        file_path = tools.get_input_filename(value, allow_missing=True)
> +                        if file_path:
>                              f.write(f'append {file_path}\n')

This changes the behaviour of testNxpImx9Image without the test
noticing. It writes 'mx95b0-ahab-container.img' into the output
directory (passed with -O) but the input directory is only
tools/binman/test, so the file is no longer found and the 'append'
line is silently dropped:

    file 'mx95b0-ahab-container.img' does not exist. flash.bin may be
not-functional.

The test still passes because it never checks the generated .cfgout or
the output. Please can you put the container in the input directory
(e.g. with self._MakeInputFile()) and ideally check that the 'append'
line appears in the config file, so this path is actually covered.

BTW get_input_filename() returns the bare filename when there are no
input directories at all, even if it is missing, so the 'does not
exist' message is skipped in that case. Probably not a problem in
practice since the Makefile always passes -I, but worth knowing.

Regards,
Simon
