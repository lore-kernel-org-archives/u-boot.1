Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67DECCF2E3
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 12:57:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AD3A60670;
	Mon, 19 Oct 2026 12:57:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n7I_q-pxKxsR; Mon, 19 Oct 2026 12:57:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4EC7E60634
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792414669;
	b=OrHZRAbP21j1xcwayW+1wePobLJ6DldEXvrylrJFqEIQAgseNO3eD250GYjDDAt44waM
	 XAcyUbO8+zvvQlIA/IXMu3P4NxVFlDpMbDYpqqYvGqmS+plIN7N69u7MYhymhtRKHO6He
	 N5niLZKtt7owXiNa+A+epsD6h0jytMYoGQOC+rugeMB5Xi2RFKr4ZP6LmcRyIkdVGOdfk
	 uw2SAKha+lYBxQgB8YxzIcbmZ79lDT4VeM8k2GX3Q5a572AU3TC+ZYbQUKtixwG3Dv6AR
	 5pXrwijqVGHgEsp8pCJhEZs+x+harJcKRZUSaIHedggR9DOuH9Opy172pd/azHk2HXA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792414669;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 from:In-Reply-To:References:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=UAyHlwUIjwAez8/PmNpgYttiEadV7NDZXIl9AkzizMs=;
	b=MCVMNn0lZRiu4anI68gIoOfSOQTojUCZl8OZ5yuRWRDt4FKq8nuj/e8tbSWEkpgCUBOO
	 k1+C3NxJIRgxz0L+iS2MjaSXdVzEq2R0gmyWeuHL+IsJ2jZ9tc80kP/Kt3osul+cjh58M
	 BV7I6i1flisSs6n4HKo86iF+A/nMirliK0XxOPKbhPX/oPpvaxUmWGDLiEQaNxofaPNLC
	 +oaXDmV6QZ7L+TY91ck7W8DvYvlkTrLBcGT0D1bAKPXPNwN23tj9oTOkQD1vepfgWlFf2
	 //iHzaov6r12BzXVFbnogfGm/YP2KMyS8EdnqqgFH+TSnL1t6+DOuujF1q8v+6zZs2A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792414669;
	bh=UAyHlwUIjwAez8/PmNpgYttiEadV7NDZXIl9AkzizMs=;
	h=from:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uc2mWFbg1WznRC/HJ0dazLiYpw5Lt2FM+VuevVq2/x0k+h2DznCnETYLOrsF9dIzA
	 hu1DyTecWTSiHQECVLlFRGoFAoPXuc5YX4IldSqG8Nf0p7Eg7cet3x4cmyY8VOFWQI
	 j1K0pALRUut9nPARGEc4qNI4xoEkVz3qG5B50IyhkzmzAXynJrwLfc6eB5f9BbZw8y
	 DaYGxAcV7u/UGvmx8DipI4xpVWcllM6zQqQYfJmcOZNgZr3eomXoaSHCsGDy8onF9i
	 26/IbVc1gc81YzV9YpfVdSEUI1przj1EsVfGmGK9hspk0LjDOyn7/iZ32Q7zKmh/0V
	 Wf/kXI81fXtwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4EC7E60634;
	Mon, 19 Oct 2026 12:57:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D08531E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:57:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C23C1405EF
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:57:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aK86dFqWmJ5R for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 12:57:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5326E405DD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::533"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792414666;
 b=hyWiiHQ+fQsBuUN/gN7uUsmmEzOV3Yl5CjMrLW2oeFBHL/VDxB+uesxPsWror6QA8Xvl
 OGuzjWVKKYLtMm9TWkIUS9aipK8a0OfZnG8w92r7BCvIO0NEzO87uV9WohLkRiUXFT3mq
 ne8ehNW7cMcdUWETHsIEJjIFlXgiixYLS4nBDZx3p959I8L2I/I2IQBOuIi6IfTcHHoNp
 uMEujG8mheI5ZBxQwOkmPN7qGsX+Px21zmybDlKPprWC1I4rz148ns6x/YHK0ka55svbW
 qe+NPhYR/afbJ605BXFaW7MdkjjRHLV2roqmTiwvGiib+KyTtRfw4Ow4LC6yxw5D4Xw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792414666;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:from:In-Reply-To:References:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=UAyHlwUIjwAez8/PmNpgYttiEadV7NDZXIl9AkzizMs=;
 b=qfboXuwf2bs2A8AtdaElIw8b553EUlSjSqp/BZFFq2YLAxpt9fAZXiKKu5//G6nIkZ7Z
 o+Xo4oNvehRuP1IWhv+XuXUfkSQurBm3m9jxTzxAyZiAavnZDzu0RF6M5F+Dxd1kdVN/M
 oLV9gxGWRT6YFYV++Fvm5M8Hn5xLELWwux0SiUrBz9KxmOn94ZSQvJCwMuJHRdAIgYHN+
 t50zBvRsme+ZeOkDg9sWsEaJ1F3qmtI+VILd4qinj7k1/mMuMZ7sjYtBJ0LeUkzV9U1eA
 RhfumWCM/9LXm4iyvLqGSaZh0oHbKsZhxx1eLIa8NK7sqHMMTocmQPtC1oPHPQSDSww==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=RftSHLLD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=RftSHLLD
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5326E405DD
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:57:45 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6b167ffd132so3547230a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 05:57:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792414664; cv=none;
 d=google.com; s=arc-20260327;
 b=ld3tVcQUgSTTuzwrT0cc3ocvsEBqhkzC3ymhAJVsSecY0yztFcqjDZ34HR+dP+fOHn
 ZGTlJawqmFR9Rqh6cAfJd0V7OE4cVuXlwEXyptD0GQJj4WM8IWC2lGoQDpf+wG7W+w+4
 ogLrucLuUerdV2aijZcynWmHc7IJD4/hz+dcL1fqxFvJbK0q0hnloHH0BHa9HeffEtxi
 xYfZT2SmdsPleEaY1sazV4yOJ95OETKhWl5yYtWZfhiFA3512syzVIgJWkPp8PXQSmMZ
 QtfocSnvUpd/BXlGSYbZpFnH8ZQb06thb+9z1nZtOPCEHEWXFEkt/0UOYdPIvfS1OYlQ
 is3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:from
 :mime-version:dkim-signature;
 bh=UAyHlwUIjwAez8/PmNpgYttiEadV7NDZXIl9AkzizMs=;
 fh=KgFdsk7dvNj09AdHplgevb1NqDEpb2+N8vXtwYHKodU=;
 b=RcZGSffUtrNjnXdp3v+beoUIAiAlTrRo9s9y3RZ2Z8x/9R6E6xc7PUyU+V04KolKlB
 Aa1TGVLt0DwRuoyVn3BM0HJfoBolaVpr20khtQcmVwQAlgspN2DJK2ooXcCIRNLE9Xa/
 zYH67vW2DS2/pJ9gQ+Dv4HTmbyJ30PBlrSLyOWvCsajd2+J6Qgoj7PTHNq5Sg2RBZ28y
 rkaLRv74aDGLjsjUV2k9f12+xBJexfT1y/QI9ejPRK817ix49WsAlUsfiSGksN1LXwYC
 H0cPElG4f92wSgchBIIgZItnwpMIBIM2glBWgQQPaznLfBUhM7XV6S4tHbV/tMirwFt5
 CMHQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792414664; x=1793019464;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UAyHlwUIjwAez8/PmNpgYttiEadV7NDZXIl9AkzizMs=;
 b=RftSHLLDh5g+WvJQNbgL89Ywi2jiFJXk1oD9Q0utQ2tZtvkkbjXKXZbcUE58FK8Zi9
 MD6Deni54usjUzrg/3HBo5fhn41vPhKKu3RqDE7TNVRJ/gmVAnTTacNlnlUMG/t/+x0A
 edbRCfITTHq15RUdubrTxx1+T/rkoWKvwsXjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792414664; x=1793019464;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UAyHlwUIjwAez8/PmNpgYttiEadV7NDZXIl9AkzizMs=;
 b=JSDzFEoYPjcuezs6PlyvXgpzLPvo95qsrqOXwmFb7dfRRjHJaKOZMsRfSWNxxQOLLg
 gNR9uhFwFXErCvk7s6bZQfx/7FBG6pThXbFb8dJEyZ6NxcFsDTzd8y/h0YDgU7WTKqQl
 y8d8V1SoYc28swt9qQ4YhtROhXd3kP3XWmzYENnhyWCUxfer8R376gNbjzKDOvFHlyDL
 OtIzDiD4h8ju3CJSMpZinytO810/f6YNQHHFDrkP6LuEcsVHlhaKGNnirORgWZpHemDG
 v5KhElZaeAltL2bCyHsxE3UEikWMT6CjbKrKa2YRW/9yFfWheCgAXsj98mNr/SZxct77
 BO8A==
X-Forwarded-Encrypted: i=1;
 AKwUvByZlXvh5Uz2TeCZQOMIKBcY+3tEuzzWyGhOjCAAAv4xE6gjjyMANfyyBK+L6IJsYkWDtNeAgGw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLXzNyG1ry6+a0mBUxf7oGZIkeX1Vj12YjM1N9EgN/grgQx//u2
 a47vtlHLS9Er+nlqFmFYQCJX/ooZtDpXWbiM3JEEyc5M7HyzKIPslrW0Nsv72YDALFM3XpM0yDE
 e+keokpHRoUxeYeFNH7fdBbJKnNn7nU57jXHWXCcA
X-Gm-Gg: AYBFou3zA3Cx6N47zM+CDVyt4ajIc7bq9dXiAhFwmFXMtyBi/mmbVLcDkbm2uHrEacG
 GBCer2wFSzn3e1n2OA+UsUnWIaR+PCNooYgs3dNgRjmVbpdxpkh3TgH+SrnG6a1+tjIxYnrBQuq
 E0l3uUljyosCO8V2mhuPDWlHOJNmOCf4J0pEl0/uGgQLForWaRuo3hqoSVotREc0Lb26RhUhICZ
 qS7FoRuQaFwMo7GR+tubjid93X3FS18SnJCn3OCTj16duViz93m7jdDQOaYbN8F7DH8RglQlW1F
 lrQ7o7kY2GXgGVQGbnH3w8XkpSF01Ifz6S+qP6GDBwE0soTiVwObHDoJ49h4aPW0
X-Received: by 2002:a17:907:9720:b0:c2d:b9b4:f4d1 with SMTP id
 a640c23a62f3a-c419a257d21mr570509866b.6.1792414663882; Mon, 19 Oct 2026
 05:57:43 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 08:57:41 -0400
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 05:57:40 -0700
MIME-Version: 1.0
from: Simon Glass <sjg@chromium.org>
In-Reply-To: <20261013150127.GA4042005@bill-the-cat>
References: <20260923114940.349985-1-ludwig.nussel@siemens.com>
 <CAFLszTiM+-BsYPjaw7aD7xfzU+3kK-BO9mkYKrtXpjPOv4SjcA@mail.gmail.com>
 <11fb0589-8ef2-4870-8490-077389ce9e53@siemens.com>
 <20261012144457.GB3722450@bill-the-cat>
 <44849c78-b187-4a20-bf2c-0eebaf8a2e9b@siemens.com>
 <20261013150127.GA4042005@bill-the-cat>
Date: Mon, 19 Oct 2026 08:57:41 -0400
X-Gm-Features: AclHuK_iLd13zO-Hx5jG-WNIrvMvoTdhnxJdmokJqpWmhnzmChjJCtByE0xHOJ4
Message-ID: <CAFLszThDcdt14Chi=UeO0i-gpzUvXMQR1Dd8c1ZVVk6Xgtvidg@mail.gmail.com>
Subject: Re: [PATCH v10 0/7] Improve FIT signature handling
To: Tom Rini <trini@konsulko.com>
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, u-boot@lists.u-boot-project.org,
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Raymond Mao <raymondmaoca@gmail.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
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

Hi Tom,

Tom Rini <trini@konsulko.com> wrote:

> But then we would need to provide the whole device tree, yes? I think
> this ends up being a tricky case because we're on QEMU for this. We're
> just checking the signatures on later loaded FIT images. Maybe the
> series that adds SPL to QEMU could be helpful here, since we do have a
> normal path there for applying an overlay to a device tree, I would
> swear...

Agreed, a whole DT is the wrong direction here: U-Boot cannot know
QEMU's runtime shape (memory, CPUs, devices from -device) so it must
keep using QEMU's DT at runtime.

The merge code in patch 1 is already doing the right thing in
principle: take a small built-in DT that only carries the signature
nodes and merge it into QEMU's live DT. The remaining gap is just that
OF_OMIT_DTB=y means no built-in DT ever reaches the binary, so the
merge is a no-op by default.

So I think the fix is to arrange for a tiny signature-only DT (e.g.
generated by binman from the keys, like the normal vboot flow) to be
embedded when FIT_SIGNATURE is on, and leave OF_HAS_PRIOR_STAGE alone.
An overlay fragment would work equally well and is probably cleaner,
since the intent really is 'apply these extra nodes on top of what the
prior stage gave us'. A test under test/py/tests covering the merge,
perhaps using sandbox or the SPL-on-QEMU path, would catch future
regressions where the merge silently early-exits again.

I can't help mention (again) that this would all be a lot simpler with:

https://patchew.org/QEMU/20250405191352.2597585-1-sjg@chromium.org/

...if we were able to explain how U-Boot's use of the devicetree
includes configuration information.

Regards,
Simon
