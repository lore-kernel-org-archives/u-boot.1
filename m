Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C349AC55ABF
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 21:26:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A2AC607FD;
	Wed,  5 Aug 2026 21:26:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DbTAA3h4lUm2; Wed,  5 Aug 2026 21:26:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B76A6607EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785965160;
	bh=xoeSdrKwvulEiEJgWwlxwGUcxPRPZax7rH9k9sbbK7A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a4NWwnBdZLdDI/G84CL4Kp3BFfwKr1xSY36t19CF1LScxJfUXGSDb5ZKGaiQAjb+p
	 NkmdJbdsvsPMPFvfKc6t1Fh4UvNFZVEoDbAq18V94oGov0GHCMTiQzsg5xrOnObvHp
	 oez968xtGaI1tVGbdH6pXbfaq2tz7G3WX4/8lpygq9U0OB04FBGNunBXEyDhHxzBeG
	 cqzvUd4w/7dTpeYTxwC8HbVuwC4VvipTLuYlozGFmGkaI0SArvUJCVI+oEThHsFJn4
	 5w35eBymntyV3eJ0qa6Cm3rmY75G5wgF3nqmTJW0Batj+qzz98odPvyPimaOJlKhOY
	 0R9Dd7l+IBsTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B76A6607EA;
	Wed,  5 Aug 2026 21:26:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 12C6C2A8
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:26:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ED486407BB
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:25:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nqPi2T_eTwyT for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 21:25:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4DF1A407C0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4DF1A407C0
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4DF1A407C0
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:25:59 +0000 (UTC)
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-ca766c1c9ccso1180880a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 14:25:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785965158; cv=none;
 d=google.com; s=arc-20260327;
 b=rCLD93y7wnHv+AeIbcRF7apLChVJOEBLdLcSg9qCIkKS8HxGPOMWzqLAyDHClH35ZW
 RgFBIBYE5038KUq9Qd4wmhln1f8ALArAaG1QFfG1pbMa5VJACgrpjQPo7dHp4jwt0ce+
 kP4UGABsaS8lEliVfRn+ECId+nKK9GrNkrdhcMdLoyl3XBu0J9KUkr3rd3EzCXCTrgA+
 KyvSH2byaMkvEnqEhi8IZkH3gYRTXkOt+zvmvPShIhqrTZxMsbWWKWQecRXox+1DKCYk
 wE9cRx7K14fZ6rh2WiKnQCY/tuXeRqgZOej+V4EFJU8d65MtG9+GWZgDFEiHh6JhV8vy
 /+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xoeSdrKwvulEiEJgWwlxwGUcxPRPZax7rH9k9sbbK7A=;
 fh=VYMXrWVFJFI77ZV7Fhg4Y9ydbPulMkBK+poYVK1sauQ=;
 b=k3O/bvxhoG5pjmhEaCQkcqlDp01ijYHVjDgWTdEvrf2zWHGRRnW2QRZNmuWHth/fUi
 lh5N9psk8m8B61GTio4CH25hFrC6mm2q1lv2Y5NksF3wPCBbYp8VfhIhx7DjuMKVJfqD
 Nj7etnRnu917X29F86/pIWuv2O1Yi4nas8fboa0i76osuf1zBTDv/dnFBupANkRU4HYn
 sACvZ6AJ4A5QtmLuWNgjxFJFqCrAxqyC+C7wXLFBdhI4xiUl6vMOXtQ1DO1vEyA7nM/h
 o4JDoouRsVP4ZQKZnyMM7ANayFo74P/RjyON5LJt/nFtHQwVyzZW0qvO2VtptLJNgjn0
 dXjQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785965158; x=1786569958;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xoeSdrKwvulEiEJgWwlxwGUcxPRPZax7rH9k9sbbK7A=;
 b=NbutwBOG8dMAy6lVjppwL1OuYu/2137hP7DoE0aIpdBLBnswuNpOwUSnVPLpCsueZS
 B6qH3IkCPIT2EcplSFnLDRwVQij88lOlcmTVNIUHMTkgw0q3Pf2wx/YH5+00fPeg0MSw
 dwCcbIMZhOJBuMrPQ8u/NE1x5AfP7tP0lXGGpc2XoKG7CAF9FNT5Ra7bWxbxWLrAJUqY
 GkRvE92w4kZ4S/ne5ks914wAB79Keks49r/fJcagHi5M8sv2luy4L7GpPgumxJIrIuSS
 2LraDz/B8xe+JrmWoZ6X+EPEuXuZ3zfWv9HakrqtJt9nlzQCjfpLdIzbKVmOWF5C1l0w
 7aXQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqDLq2kAksY5QF5k348HarBPE8qJvX/7n4KGvUuEVX7347fKJzbEfQ3aOBLw+KhJyhVuNG8M58=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx4rHmt0WWMzHtJYdBr03tq/glr4DJjkEFNU87rQptoFjCmVf7c
 gJg2B9sR6v1iWIdN4uH2tUfXjZCjpQpYmMVOfBMutpmatur8vIJ7ydIS3oDrp5baNfIqYMUrvhh
 UwGw6jinX9G4odYJ2yfG/hmOBwabMp9OlEtBcEDHtMEriW7xCQQo=
X-Gm-Gg: AR+sD11C0pr1cNYLn53kZA/o8osdathOIYVjLcNCLvBnKAWaWkf+YzwjR98MtrZA/QY
 qkEep+WQOVNcONZjAM3B9FH52Eo5p1nB2dQhvR5zQjziBQZ8AvhF6zFMYCwKbzRPOAN27m6PP9Y
 Z3mUCWKgqGIM+XgVhb8vedyRBQA4UCMUHcyYk2apdjKpBoHc2cUX9xgyZtq3nAd/a2Z0gYN4ilX
 ESpolaPT8j3boq9HvkEUUm83YN0nIWsmehM/+1y0qjcxAO7MKDISJfOC/S8ooYw+Hnq2SuONT61
 RcQsQkK4eRRIoBV7+dvyQiO+hBoWJ2dmPKL2bZwYi1g=
X-Received: by 2002:a05:6a00:3305:b0:845:eb88:3d74 with SMTP id
 d2e1a72fcca58-84f2e06b682mr11904187b3a.29.1785965158558; Wed, 05 Aug 2026
 14:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <d15555b5-e57b-4567-ab70-56d48fd4b878@gmail.com>
 <7b2fc523-7721-446f-8f98-80dc61145fd7@gmail.com>
In-Reply-To: <7b2fc523-7721-446f-8f98-80dc61145fd7@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Aug 2026 15:25:22 -0600
X-Gm-Features: AUfX_mwNbjVEt_LkGZmJqsJedMsgUKAW316SYYeS5lGGGxg6hy8WIOkCc53v9II
Message-ID: <CAFLszTgZoEuMNEqbednr3MmAVpEGbnvm5+kMFdyQCpQZVB5h7Q@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] rockchip: doc: rockusb: remove reference to
 README.rockchip
To: jbx6244@gmail.com
Cc: u-boot@0leil.net, kever.yang@rock-chips.com, sjg@chromium.org, 
 trini@konsulko.com, u-boot@lists.u-boot-project.org, 
 eddie.cai.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785965158; x=1786569958;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xoeSdrKwvulEiEJgWwlxwGUcxPRPZax7rH9k9sbbK7A=;
 b=Q/6/yiOIamkOIdohFKM9BR9HdYxX17AhiQI3kKNnwBfDiFen94RsBkzMSJAulzJrZ2
 K8kuDLwNAZatPb0jyoGHLnJkPBhzhVunCSqXrk7C/cuZrQilXPynAYqvKmPEWR4EMYJd
 vuZQZz8t1a+Tahh1zraSlO4u4sO2fOcm241zs=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Q/6/yiOI
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

uOn 2026-08-03T19:09:22, Johan Jonker <jbx6244@gmail.com> wrote:
> rockchip: doc: rockusb: remove reference to README.rockchip
>
> README.rockchip must be removed.
> Remove the reference to README.rockchip in README.rockusb
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>
> doc/README.rockusb | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
