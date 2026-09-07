Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61ECC79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 23:00:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E39F2404EF;
	Mon,  7 Sep 2026 23:00:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qWMlD1_vUG8w; Mon,  7 Sep 2026 23:00:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F13B0404E8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788822050;
	b=OVHZT4dBtximYeXTqsA4Qs7hx9brlGO2MH7HWD+oUcFFiE9poHsjQ2zo5ypwSOUIxQ7c
	 0a84o4kC/YYYYSqvR/ylBhwDkvAKIeou057clVkK2ktEG1CD2H/xIlaftJyj4QZBCGcDe
	 GCM80w3iw7MUwR4fPiq497kKyMgaVzSYE27Rl3WwDJuwH858ZtAUFY/Y2//L8ls0mxa9J
	 Qz6CTPoHtgYVV++V8l/chAj79KVfNkAJ87uIZbWV/P1nGA4tbA7HG8bruGu4XLCP2nl17
	 b+9K/Seye4dttWZuvlUYo/ZR++BsWESrPTxUzterHYM5AdFU2FjpKctF+XGlEff5sIw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788822050;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YYXeVwf9ydwlWFHkG9Obsw3uhriz73098cWkLHWehig=;
	b=SfV9MA9h+hByDajmHQx0J56d4HCMaxArrE5uosWbTMc/twJkjRVtATneA5bfWCfF3W32
	 iEdLW0sNND6bmwqWWhhQnrDaS/UXDH973c/j3T6MLedXywZweDmGwkNmq52tMRyomwnX1
	 e4GXeYdsXbXhsU/ceuxCYDL7dELKjXiRNC54IyF3KE+6WCl5Le9G/KYiZ86xgv03zib3T
	 /rlalCbu8D/GfIfbx8+wv/zGT8E2tvJslwXwolO/k5n6sOWLt9Qw0JrPmIeofd8Kep09I
	 6OdiregzCNw4JSFmHqTjLvcmVAcwaHWS0xI+2kZv2SD+ed6bVAiV47gO7A2NdYCOGhg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788822050;
	bh=YYXeVwf9ydwlWFHkG9Obsw3uhriz73098cWkLHWehig=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xr17pxCrtJkY5fClT9EGIjEdnBcYnzBUCQ527I3mijyPGljhu4HnONNKPShP0WxB6
	 le3Kv9F7n0X11bxY0hW73Y4mH7bBtwljQ9esmDilJTl2kmWpioEmj9xrnujCUmH3g/
	 LMJAX4Pg7P7Jz50WUfTBOjM3B7PnBJQi7SdiT/socWH5YRdVJqV5h6VnjjWndJnj00
	 1zG82vfB21VY+VBixqO0igBxtsMo4LYqZuu10gcu/jiH6UayaFsc++oKQCm57RWGKP
	 gFzqN3pTvc8RgApcju5qyxRv1kD5WrKM4jFDUTWl7dw0iOBBg5HaGUK7SDDW51GVHH
	 Dp16yW5rMGjFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F13B0404E8;
	Mon,  7 Sep 2026 23:00:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C1204AEB
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 21:27:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A6CCF60690
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 21:27:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 84OOBszbZNrl for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 21:27:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BDBD76068A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788816436;
 b=p0w4O9kZjtyJ+PCkFT6axBKCU8jwiWO9MXWtk7A2x0P0W6M6nAhrD/XDiqi9LYLE7s/G
 ivUGv1vjhJdELGjjv/773fNG57JRnYQSHgpyObin5M2WJm3yuUk2ZDrPS9/lDlDxYuGYJ
 xzPo7wKpIpb6EBubd7OX4P4qzZ0nfoMAbT2UM1Hxpn/cqt/xiLiUKaaW33Y7/0jfd7Xc+
 tLBm2q4mu5RzxyLfDg/9txWyC15BuBBasoH2wZfERhS+pVP/Tsyh8Pi3H/MaN0p5v1Vom
 3ejgBdEjw4KXR5NDrodKtwoeJ8dhpMS8ChgvPITSDd/Kef9H0mdXN1OKBk/8wSy+dKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788816436;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
 bh=YYXeVwf9ydwlWFHkG9Obsw3uhriz73098cWkLHWehig=;
 b=J1icfnbtRowUl1fNwcaK6W62pkB5wVRZp9doQem6XqVTo6qEffVKjFqrR+ttpvYXzPeO
 i5HBoT0Cur3EGPGgJbGtFQ8N1g8dEkycDV+mk98KmLLTkaZkQNzbJEXTuk0ihxyC0No1f
 AsD7LMocXQIegPkkn/YYwaRsMH13VOL3PE9PKvxUAKB7DB4vaOg43c/WP4hEqrF8dLWVG
 nB8vNAeeDz/Ct00cwCsEeIaECsLHENpmmV9cOjA95TpkWZTHwLYzDr35d8HdcEbpE3E2p
 IjKzMh24oCytQLrXS8xiX4ca+qMfDIUj2J5cTFPhHGzWY4AVOcMG1kqS5VyYUAoP1jA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RX0+8ICM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::b12a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12a; helo=mail-yx1-xb12a.google.com;
 envelope-from=0xiviel@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=RX0+8ICM
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BDBD76068A
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 21:27:15 +0000 (UTC)
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-66e63afda8fso3101465d50.3
 for <u-boot@lists.u-boot-project.org>; Mon, 07 Sep 2026 14:27:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788816434; cv=none;
 d=google.com; s=arc-20260327;
 b=lSKQHe6WaoVRKmLJbsFQ7gfLAGPrsoiLn6ppK4ePR4UrxLGALEth2A5wia97ek18ft
 BPEkoA/2Hz7WxHSFS/IqoXW7AUaqY5EVN4HrdbrtjH/k/bvwWjs8T3cPTPsi0bP3I+2h
 0AJxDrCNWVttIJrvMncQasDNYdnHhDBqiwwJZcYlNjMNE8UfgS4JOiTuzkCsXGep1Gtu
 y91qtFeqsYrvUiabSxOo//IJq/18KODx6EJXfYGGzjagXJzxiZGds2xZcSrSuo45PQhi
 snc80YrXWIa9hdcghNPYwsKN/WUE316x9ULiWfH+fTpIJFLNKFxS7LNlP+/mrSk+uw5B
 6zwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=YYXeVwf9ydwlWFHkG9Obsw3uhriz73098cWkLHWehig=;
 fh=dyJC4lH2AAE/7T8PCOe4Gegoutx/zB9wxn0wUSqF13E=;
 b=mAV6edg+wUqjDG6coaATlKDNOTaa5dEgDMD8TSSu7RDTGgj3HFmDcb4VjjRiHaKzYu
 NWheXVxqcNCoWcQGRK3YvnzuqivKBQDUU34Ru2hzxZ/sAD0Oq7h6WwejHa+YR7ZknHYu
 gjLmoV+uxPTncImau7A1rN1qQ1aultCPPzjkf0Vyms62n5wPhHmrFleaXV1TvytRUIUH
 NoCMavYX7PbhdOouH9DKrdzXItYYH2PJPICgCfp+yEtyYodwB4DCaoU1HKZvpk2LQURX
 YI5ZjyH6eWrjLxWaK9RV/Fsy0Wwn23vHCZF/pVcL4gJOjmEFsJRZnXQMlpz7ce6JdWyz
 ehAA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788816434; x=1789421234;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YYXeVwf9ydwlWFHkG9Obsw3uhriz73098cWkLHWehig=;
 b=RX0+8ICMyoMsOX9W2DsUOwfyOyWtJ8dBHHN6V8PFKOlO0iuboXVPNccpvkDT6kID5B
 Sdp/dMeUxxhAGt5bMn7PSy3vxkXTwW71Nom1AkBqD50z+SATSY6ZAGgiyASfJCRfRwre
 qrsm6hLHczGEPSk4a22GOUljmQuC1Z2/qL9TUeUuVdJSHIHtdaDhkNFy3fWKVCI/Xig1
 EVgOGtB0QdQjhI4f6Sak6EY7RiX6TD+04EEQpSOCJHmQ+8K7zmcTkb4aPt+Jlw7MoGtu
 50SxPFgN9K8tDjL0amxeFcAepC+cczOC+wIwGWJwkUOHVxbDx3/EhMihW7NtVaBkZyji
 vEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788816434; x=1789421234;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YYXeVwf9ydwlWFHkG9Obsw3uhriz73098cWkLHWehig=;
 b=shtAfdQSv61SSEhx74RXCkWvPWysxIEQnsjPs4z4Ib/vhSJfWzISuuKPzHBntcwQG/
 E2B0catr6Act9hzBFNKjcJxDdRZq40vgwoD5/Jp8ZCh4IYcPe+SaC+gOKu43UK0Ry7kY
 GgIa+sBW283EbgKxmhkxiBvzB3GAN6+M1fg6IvVyOYRdp57pbkOPyO/hroAFlccUQ9ab
 qWs3gPWaLxkbfyMnviN8MW9V02eQmmxvqpviTFZiBI4KkgWhquPtQQVC9LBWxWbOXxzW
 PwtN3IbCxg/Ws7ds9GhFbLie0rEO6rLoEvN0JsZ4gAhSqL74N3RDHJMhDxBspLaBxShH
 Rb1A==
X-Gm-Message-State: AFuF++k82A2rbWS8EHd+7VcC/xX3IVQbWIVfi5Hmemxg426txOgAFtR4
 z0lw6n/wbgIU87QeXYFAD3tZD6XAOCVPDbEuNxgf5iM+baJidzjOLvNa/SkCgGv6fhcE7wFfAeP
 2/KDSPq1ZJsEJYsBQQVgolL28BEWPAmwwNrI2Br0=
X-Gm-Gg: AYBFou2SmkHSzEB8fLHvupHp0eJvDY73oDqoB3D5/zl/wf+xAu+3pc4w7nU240JLvIG
 9pjEB0AOUN5ZvsvXuyRKfzr3Bc4jWVcLru7KL33v3Rlgb1AYp+9JGp+eX8KNMJnCJ8ODG4mSJ/u
 zDwHwXYl1jUsG7jxp6CF17Dl79lgrHt7qST1bpOX7A2cn7qfzIlgGAZdiL9yAgIMRndffxfkbHx
 GSKMppgiNcx8Bv5EmbScMF5Kd1Zsv5kItI0dvGn66aRyStZTUYGZaK7tqVsTU4ML+psjaIZjwqU
 eSUS65h89Z5xN1u6uas2W0MBOEIAUzQnp+V1QbRKh6sNZKfRbhNgJkFXRHGPf/N+7/5z0iarXaM
 YVKFDWw1asHfFGtlD2E8tsMIvzYFpLzn2yE9/j99a0jeE7c8anJXew8J42SB6bQ==
X-Received: by 2002:a05:690e:1c20:b0:66e:611e:746f with SMTP id
 956f58d0204a3-670f880c383mr309674d50.40.1788816434019; Mon, 07 Sep 2026
 14:27:14 -0700 (PDT)
MIME-Version: 1.0
From: Eva Crystal <0xiviel@gmail.com>
Date: Tue, 8 Sep 2026 09:27:03 +1200
X-Gm-Features: AcwNN1VdwxkOAF2B6yBNqEpoAS2mWJR8fD901ve-UjI4h-snwKy042oshL5rgLE
Message-ID: <CA+pz=k+hAU5dqbO4GOLJ0fRMRdyrq=kTSnwUc0OcR3r9PotUgg@mail.gmail.com>
Subject: [SECURITY] FIT signature enforcement fails open when the control DTB
 has no /signature node
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 07 Sep 2026 23:00:48 +0000
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

Hi,

Reporting a fail-open condition in FIT signature enforcement. I am
sending this to the list per doc/develop/security.rst. I am not
claiming a remote exploit here; the issue is that the verification
gate silently reports success in a state an integrator can reach by
mistake, with no runtime indication. Details below so you can judge
the severity yourselves.

Confirmed at commit b4ac71db (2026-09-07).

Summary
-------

Both required-signature gates return success when the U-Boot control
devicetree contains no /signature node. Verified boot is then
effectively disabled, and the only indication is a debug() message
that is compiled out in a normal build.

Affected code
-------------

boot/image-fit-sig.c, fit_image_verify_required_sigs():

    /* Work out what we need to verify */
    *no_sigsp = 1;
    key_node = fdt_subnode_offset(key_blob, 0, FIT_SIG_NODENAME);
    if (key_node < 0) {
            debug("%s: No signature node found: %s\n", __func__,
                  fdt_strerror(key_node));
            return 0;
    }

boot/image-fit-sig.c, fit_config_verify_required_keys():

    /* Work out what we need to verify */
    key_node = fdt_subnode_offset(key_blob, 0, FIT_SIG_NODENAME);
    if (key_node < 0) {
            debug("%s: No signature node found: %s\n", __func__,
                  fdt_strerror(key_node));
            return 0;
    }

In the configuration path, reqd_sigs also stays at 0, so the closing
check

    if (reqd_sigs && !verified)

never fires either.

Why this is not caught downstream
---------------------------------

In boot/image-fit.c, fit_image_verify_with_data() the per-signature
result is deliberately non-fatal:

    /*
     * Show an indication on failure, but do not return
     * an error. Only keys marked 'required' can cause
     * an image validation failure. See the call to
     * fit_image_verify_required_sigs() above.
     */
    if (ret)
            puts("- ");
    else
            puts("+ ");

That comment is correct, and it is exactly what makes the missing node
fatal to the security property rather than to the boot: with no
/signature node there are no required keys, so nothing in the chain
can produce a failure. A FIT image with absent, malformed or invalid
signatures verifies successfully and the function returns 1.

Threat model
------------

To be straightforward about the ceiling: the control DTB is U-Boot's
own, so an attacker who can rewrite it can generally rewrite U-Boot
too, and in that case this adds nothing. The realistic exposure is
different:

  - A build or integration mistake that omits the /signature node
produces a board that boots unsigned images and prints nothing
unusual. There is no boot-time signal that verified boot is off.
  - Platforms that keep the control DTB in a separate flash region
with weaker write protection than the U-Boot image itself.
  - Downgrade of a correctly built device to an earlier DTB that
predates signing.

In all three the failure is silent, which is the part I think is worth
changing regardless of how you rate the first point.

Suggested fix
-------------

Minimally, raise the visibility: replace the debug() calls with
printf() so a missing /signature node is announced on the console when
FIT_SIGNATURE is enabled.

Better, make it fail closed under a Kconfig option, defaulting on for
FIT_SIGNATURE builds:

    if (key_node < 0) {
            printf("%s: No signature node in control FDT - "
                   "verified boot is not enforced\n", __func__);
            if (IS_ENABLED(CONFIG_FIT_SIGNATURE_STRICT))
                    return -ENOENT;
            return 0;
    }

I am happy to prepare the patch for whichever form you prefer, and to
add a test under test/py covering the missing-node case.

Disclosure and CVE
------------------

I understand from doc/develop/security.rst that the project does not
assign CVEs. I originally documented this finding in February 2026.
I am happy to follow whatever timeline you prefer for public
disclosure, and will coordinate any CVE request separately rather than
making it a precondition for the fix.

Regards,
Eva Crystal (0xiviel)
XSource Security
