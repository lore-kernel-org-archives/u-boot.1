Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1144CCA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:24:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C81A580C76;
	Mon, 12 Oct 2026 14:24:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T26CGh21_8NN; Mon, 12 Oct 2026 14:24:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C603A80C55
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791815042;
	b=Zddccm+X+aWmJJxLkX1/wFspaMDpQ9GNwHOifEELvt395ue/TClO2v7yNfHqJkO0qQDE
	 csoscL7dd2F/11vEFo1Zu5kyEhMKaYTypowPGtM0VxUlcTqowE24FSHbZehC1IWxGuEfK
	 9bEi60oRYg7tjB595MW01nXeCZNoWrkaskxB6Bge3G4MMYNvmv3qjTdN/SjxBtrEut5hu
	 yOzg3YurexVTNTDuNaqZ2Cir3I2PwmWQ+FxoV/zYEVVLnDZ1u7/ncV8hry/tpy+nUG4pz
	 3GnDFoY3O/fpQgsz5WtHkvPhdVGZ2DnSRaSsRTfFXZB+gONEho/YGKRQ5GgOeQPpRWA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791815042;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Ysyc8y8/FhAoZl+CkO9yieii01RfUOzxo1I8CHg5MVQ=;
	b=K7xLhmDRDmCyYW+XxOVNXJOHTe2rqm8TZEPUUBpYhp/xkB9BaNLk6Kw09Qz9fGF9L+XL
	 TqthfG/XmeOFLro5bksgg3HrryRwE+x+0dtG6govFF0jhKmjSLa4z5M4towT8pRZ5tNaB
	 7JeqhBlth/UHnn3Y7Q0FKWUJ7F9/YIdC93uNhTrs//JlpA6wyXPSVJQqvWQmdae81enMM
	 d5lm4LI+PTmbABP0m1LODsbEA3HZ1QymvWipri/vvZBQbxOAhSGwCiLxjQ5M0yYpHQ44J
	 r4QJk9/mBSIRmPjheQ95ESZhSLGw7OokV9f/RW729Gurjbt40YcKnrh0DpSBWzXCmHQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791815041;
	bh=Ysyc8y8/FhAoZl+CkO9yieii01RfUOzxo1I8CHg5MVQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GsNG7pQvo9ATby/rm4ZBZkmnMlWBwyUCsoicPQbUtKwGDICFJ2uk3fJrk7iSykO+D
	 TDewlY8BjF7WFf2dJWlI5nFl+Vh5Va2SNcHFyON2AqSjD4d5j+9rtrERcvGFUD2wS5
	 g60WteZS7zJ31Wi5aa6IfqoHuThIeo5O643Fo9pgwktZbuYEoxsm0bzuYb2sjW3wFj
	 CVIJyC7CtjYcSPSWJ5lfe9O5LXw1olKvIvp/Xjy8RABhO7LuXOLUJ9w0B4xGtEVV/C
	 tFRv6MB4VHFWG3J1C9mprRPBvolZrTzGnfpyrTNIWih2DuCl3yPlr6pOAbfq0/paVG
	 gu1xsl+MgtXeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C603A80C55;
	Mon, 12 Oct 2026 14:24:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 483E9156
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:24:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2E7964052F
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:24:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Up9nhj9IKCcV for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:23:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C077440411
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::530"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791815039;
 b=n4HIBI7QS+LPRNwcrRThsKR3klnUADBWvKL9tMfRN5jEvvVm0+7Lgx+f0+XP/Ic6CSOg
 xdoauwKG7GA8YJojFKtWCrTigG+S+EcxKhGEFrtLFOJMMGxuWxrBQistSNettwdnO8SQk
 yCXJw9Tpzh5Krh8B1NuoBibICZC3vVnGdBwgqNjVI7Ax3wW5SZSVdRLNOXkDz4dty8JOH
 9uxfelrrCcs4TyFgTlkgHpm8VQ/6dirhBIhqNGGZLUNSpVhkxGRSM17X2j9SSesllGDFN
 YBJ6PW2ue+DgKjRj3gS+05zs/kcsxyrQROQeMRjKVII/YkR899svlngLSfdyktKz7pg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791815039;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=Ysyc8y8/FhAoZl+CkO9yieii01RfUOzxo1I8CHg5MVQ=;
 b=e/SAKYcG+aeQFTgpURQXM2dv1l/Ep2N40nF33X2cap/IZBsub6/RGinazbcXOjEpqYi+
 zLgYYt7myEAKGHOlX3Oe2JJ94CovbDUH3xbamohPf8Vh/MBs47SicY8H59NOutXi6QZ9C
 LxoB23WpNNMblXJJCemq3gDBu3/n/cpY8CM6oPy4jWGKNdBAla7IvnW1xiCll3SE9KpVu
 WgWfWdr/THABkD4GYM2dQ3CgzxHYeIkI87Tz1mtlOZoL6dRoIZr0XyFdB2WhCu7PoVqZM
 5OXOYHqOePKsVtWwwGTjZkpRtf5KLfa4gQrjs7MnJuWSsQI8kKMV11W0MN600S9NS2g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KwnigwkX; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=KwnigwkX
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C077440411
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:23:58 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6b1ab2ad719so1813865a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:23:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791815036; cv=none;
 d=google.com; s=arc-20260327;
 b=dV8UrT3NilysQ0aWkuHyeZygPEadKZM1WQ/uPfiSLMJkgjLDngL4R3EpkBVlQcG2Wn
 qQJZMJg6/PFu8D+hScgmPLBA24wdf7YQkPzDYtOq23AYoNKbGV77dnN6ykZJnQ0+z2np
 ty6hjG8ByxYFnNCNgrBI41P+0PqIn51vVdbiQOKDTJDA86wBPQcB1YpEhqfzGAizKCVu
 asl3cBziJqbaXLFwBc+4HToZ12I7o1dtU/DTQC5Yv5IJUtHRRpAdJO6EiKq7DXej+dGe
 1vdZHJRJG9uXKIptcVy7CyosTpmOBj0Zq0XzhyE2gWUnhvzH4XgGHDmnWHT2hJeGsWqj
 YLfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ysyc8y8/FhAoZl+CkO9yieii01RfUOzxo1I8CHg5MVQ=;
 fh=7xXzDT8npCRyi20qvOp6JDz3Wsax/hH+8ewiEDko2KE=;
 b=GoXZR5jMzwnZ1lFrR9B+BKSoGTgn+ciIM4/+8uDgzj1upCcbp6QBpAmWYgumHhgFIX
 zhSVLmKGjKlv14MkcISNLGKV3IXIQgkUUsoai6Anl7AgFmFh6SewfJCe62ChdKGbPpHC
 VGMbJxfOv1qDi3fvddZQO96o18osobIxMOTseX3STqGZBwiXDFXr1FBTEIM4bsG5sTCG
 XNiLvnCusNUyFnLHjNbh/NXUnF8XfKFHoz4s5Ju2OES7t4+8VDZmtv8gthfRYZHaI+d3
 gJ6tSsc8sIjnEBwHvRGLCIpFotDSfVWbD0K30uM8WlWiWXGvn4Zh/LTKFENJmwWztV+Z
 Uoyg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791815036; x=1792419836;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ysyc8y8/FhAoZl+CkO9yieii01RfUOzxo1I8CHg5MVQ=;
 b=KwnigwkXRUipTAVr/96LkdIxAQousEtsBETnFOf0ZCBVXQgWUY9t5GIaN0alS102W6
 3938SUIL/XMYgqFavcasbrnfbfQYbFbPIJl/wMYwlDeulC3AMaEwf/zGyultCIG1qgfW
 b0SpN4km4Q3yCE22+DrOKoAJA0xjdx2mOkifc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791815036; x=1792419836;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ysyc8y8/FhAoZl+CkO9yieii01RfUOzxo1I8CHg5MVQ=;
 b=KKKF98mc7lVb50zNP+DX8eDwdyLgNDulCNwWONKvuvF49uQI5deoADVznaVW2vOAvM
 a4BEJZeHpRItvaQ/MdEGfQE/c4+SvdXUOJV2Cx/XWWux7j4RzGvbuXeWcJDhhu+8Il/b
 la5m9G3CLqKN/+Pz5oZ4IwM+GZbfHSY8VgVhDO5sJQBlWJ52UN4vcGVdPC3wxXkATV+N
 V6k6iW5pQcBMf/ZlsNbAGTlRi2t0aal6DoTyQ3bink7XvIu8R/nto9YgFGKJg7ncgBeg
 rsCe8GRV7HglUxBODSeevo1iEOrbCCnliwKFW6G5JEwsrS8g4wlQFt/O+N//Q0UYneg9
 RV8g==
X-Forwarded-Encrypted: i=1;
 AKwUvByt5hQhxbApjpdBoBQmdiMPXdUDj1iYeoZpg+lx35HoOCouR+o9ZQwglSeQx6pXpTTMo4t5Aus=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK4OCvDuNKO+EMgjuiCetdC1a0fl5mM8PDgWEXWmWVaPsqoV5AX
 Y7+6vgjCG5VrwxPion7QGM2XARKqGglhEhWjnMdgjjVCnDvql8GZmcv7SOHjK0ySsMWBtLHa3JY
 E7NLCf5EdhDR+fsdWLTWRuZGlBzTGGzaJRqFrOtVZ
X-Gm-Gg: AYBFou2uRLkyONCaaGiUkgJZyCDV/uq2VcdtvadTyhnwJH0/G0RaJPZ/S2Ql8Bhib2N
 HsJcQciv7YldjkSdrBXeiqfkYw+dubYHBMDB1Wsb5zHxZlhvqx31mUl7W3Oz6edV6nvPrAzaQb3
 a/SSzF8kEy/mo0RVrE4tZbqIsDfpkvo1WMMNaar5lrX8dtBXaglvtPSDbP/yBiQhVdPSvEiBY66
 XYAAlBrJHjRPXp8IGSowWCXk+t6o+XPj0CRLuEhkNcRvanfRP0Hh39M21+MMIfpGv4TbnoJeT41
 ltkc3MoObcXRWqVgjQgpymgNK+4xt9e2vUQeS5u62aMqh+SphUlGVIs=
X-Received: by 2002:a05:6402:4003:b0:6b1:d148:6e82 with SMTP id
 4fb4d7f45d1cf-6b1d14870e3mr1478951a12.5.1791815036209; Mon, 12 Oct 2026
 07:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszThvoDY2imKOv_A8W7kxyAJJjNNjRrNP5Vy5Uht6AfwDOg@mail.gmail.com>
 <20261009090559.985466-1-mehmet.fide@gmail.com>
In-Reply-To: <20261009090559.985466-1-mehmet.fide@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Oct 2026 15:23:40 +0100
X-Gm-Features: AclHuK9Al5DGnR3HnRhdH3rYXomHAM4_zPFP08TR4zS_w8QDAqinm_IJ8JQfLy8
Message-ID: <CAFLszTig_=sVFeicuxihPWwY=r+uP56maoOOZa_auFf9-GY-Cg@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] dm: core: add ofnode_get_alias_seq()
To: Mehmet Fide <mehmet.fide@gmail.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>, 
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>
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

Hi Mehmet,

On Fri, 9 Oct 2026 at 10:06, Mehmet Fide <mehmet.fide@gmail.com> wrote:
>
> Hi Simon,
>
> On 2026-10-09, Simon Glass wrote:
> > The checkpatch remark is for reviewers, not the commit log. Ideally
> > this would go below the --- line
>
> Will do.
>
> > The two branches handle the stem differently. of_alias_get_id() does a
> > strcmp() against the stem split off by of_alias_scan(), so the stem
> > must match exactly. fdtdec_get_alias_seq() just does strncmp(name,
> > base, base_len) and then trailing_strtol(), so any alias starting with
> > the stem matches.
>
> Yes, and that prefix match is also what started this series: with
> "usb" as the stem, fdtdec_get_alias_highest_id() counts usbphy0 and
> usbphy1 as usb aliases, which is why the two controllers ended up with
> seq 2 and 3 and indexed past the two-entry tables (patch 1). So I
> agree it is worth fixing, and in both functions: a stem matches an
> alias only when what follows it is the number. It is a separate patch
> with tests for both lookups, but it has to come ahead of this one in
> v5: the negative test you ask for below ("test" on /some-bus) can only
> pass on the flat tree once the prefix match is gone. The series still
> follows the PHY phandle (patch 1), which does not depend on how the
> aliases are numbered.
>
> > I think patch 5 should pass 'usbphy'.
>
> Yes, that was wrong, v5 passes "usbphy". The header comment will say
> the stem must match exactly, and the test gets the negative case with
> a prefix stem ("test" on /some-bus) so the two implementations are
> checked against each other.
>
> > Since the flat path now uses ofnode_to_fdt() rather than gd->fdt_blob,
> > it would be good to also check a node in another tree, i.e. a variant
> > using oftree_path() with UTF_OTHER_FDT, like the other *_ot tests in
> > this file.
>
> Agreed for the flat tree, that is exactly what the ofnode_to_fdt()
> change is for. On the live tree there is a gap though: of_alias_scan()
> only runs for the control tree, and the other tree of the tests comes
> from unflatten_device_tree() alone, so of_alias_get_id() cannot know
> its aliases. I see two ways: (a) the live branch of
> ofnode_get_alias_seq() handles a node outside the control tree itself,
> by walking that tree's /aliases (the control tree keeps the fast list
> lookup), so the _ot test runs in both modes like its neighbours; (b)
> the _ot test is flat-only (UTF_FLAT_TREE) and the comment says why.
> I would do (a) unless you prefer to keep the livetree side as it is.

Sounds reasonable to me.

Regards,
Simon
