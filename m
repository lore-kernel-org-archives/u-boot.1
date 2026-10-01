Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C910FCA5FB3
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 09:02:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DDE860C1C;
	Thu,  1 Oct 2026 09:02:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vn_phfR8Tubv; Thu,  1 Oct 2026 09:02:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8FD7C60C09
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790845375;
	b=kUv6R8CqrzMv5XT6SiPU/YV1krio5H/BgwbouOTmNTc8IxzoCNAPUpRdmt8xQoty+JsZ
	 kIX4Yavs7yg5H1MuNc2tijDzshUL0Sbvd2y8P+y23MLAsSsmlBO6dgIoBQ52q9ipKfw4+
	 abllFX5sciocohWQpsUN7ysNfoO3lSww8a/1j+eFPiEMz9YkVtZsj/AvECeo+w/jAqiS2
	 9W0EwVf2oo4R1cYUUzGlYMRjo4GRZtdYR09XtfHHg822NGkvZLwDcWji6vbnLTG4wQzNR
	 snSjBJHcLN4Uub7/XL0DTllNOFdGtBYsaEMaCUA5t8A3n1oTOzrrkY+ffffXNqDO1BQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790845375;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=MI6GM5dqgPM6FyJ98R5FH3+rrPa+Vlov2JkEwoVpZeg=;
	b=GK0LoIXknZ9i++XrZDzqpLdZdYC0M/Y7leWt2jE1dZolbO3ehOxRkykwtAHkOk7NvWBf
	 a6/V/zbWGWysvCrN+reCFARc9gZzUQF+KXMrQbmFjPnbDUCZ1VpODhcVtRogzFzsR66qX
	 K7niFwd8KDPcggHe3T+5wMSp5LG0URMdjyyfgxDYdzqauACi62Mi8IhskhZ6QX3x6p6kj
	 oOHTPfvmkCgaiCicYiXQ3pMlP1TCFzIHXKVkhyYQTaCwihhsFghydcBKGI5NEYYPd4G95
	 Q0Wqj8Gl2VgKpTl8L/rkR8uRaiZOdGDW+BOoOEVX3EA4QZCNIclERryhCDPANA79Ojg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790845375;
	bh=MI6GM5dqgPM6FyJ98R5FH3+rrPa+Vlov2JkEwoVpZeg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aSkoTYWTX8cAiaX9XWbirm8EQ5rQI3TYu8Y+yplhrX3P2cviwVyi0RFP4s3PWelsU
	 +QlAv8WZScf0SlXj4wEUK9YTAftMawqhVMnWrVgU7qeifSpuEutbcy8OtUt54d5wgz
	 tiLeSxu2uE9Me8wh+mwNmDSBhJnswaXbo9GlrtBoaMIYdQQUTe3ujm+gBT98m0w1Yw
	 yLH4CWiEsH6DvJOJjr+QH1XZEp3hCjZGuN9jB2S2+eVU4TcaEzbGgoSygP3LJJh36e
	 GeLD8cCgR+Fqd+Ag59gbyrPltu/7RiD6lzqCYpeRQBvlsHtF7v6RDtoaqA/ouM5agq
	 0y2joLAVl3Mew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8FD7C60C09;
	Thu,  1 Oct 2026 09:02:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C978282
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 09:02:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2A21E40CAE
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 09:02:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cWgyWFPnQIki for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 09:02:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1BB7740BB8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790845373;
 b=sc5frNvipwwYughUumsKD55kWVFyJJKtNhIYS+OkuRvoAh3pup8GWnDWoSjpTgcbk7PD
 +dtsDnLY/GcSSaiDtWIG31Lpn6cnr3044Vj3iK+Gnv9TUfl/Al5X4rp8jBCVKbALRakIO
 hc59rxKAJ1QkEo+pTWak3iEfIseT9M7Q/LzI6ESIZVqjSSXTP/0o2Ak+2tADvgnX41GDq
 hq/UqsIQbaF05/584oY8guvoBpjYe47Vto7Ofq2NXwMcaU67rJeZNIfAN2zT58yqlX8SY
 3ukNI0CE/rMy4pcYX4yECsqaqVpISeH7w60pxK+u8zjT4fG3pJ7O9JjbCPLD0fUSvyg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790845373;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=MI6GM5dqgPM6FyJ98R5FH3+rrPa+Vlov2JkEwoVpZeg=;
 b=slja8JjSNlqAW4PKbyWtbTGFB4KGkERzCWq5nDSn1rXkR7oaGacIGHvlud25ZEfyr/SL
 bmSki/H6vqr1yqJNFzqDIrNSKKfCpnaIB+FLWKEM3KA7h8Nd8Ddm0/ny2fvJ/OS3Op4x1
 yMrEh0M+BD7pqSq9arfIOm2NcAzlsbZFas0W/LBsP2FsmBkori5sk+RkHGe6eyDytmcTz
 XUikEdeVSyBu44ST5EjnhENt9JcZtgDeFO9880UfhGz0cQpZGD2HrMhOy/Ko8f5UwOYnA
 n4ud9D8GtylRUdTDfuFG1dBT9EqOhGesWx8qfVKAfsixof+DcJSK72Y+KfKxVFcSIEA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=rFePtku0; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:41::c;
 helo=mail-yx2-x0c.google.com; envelope-from=ilias.apalodimas@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=rFePtku0
Received: from mail-yx2-x0c.google.com (mail-yx2-x0c.google.com
 [IPv6:2607:f8b0:4864:41::c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1BB7740BB8
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 09:02:52 +0000 (UTC)
Received: by mail-yx2-x0c.google.com with SMTP id
 956f58d0204a3-6756a6320f6so2324145d50.2
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 02:02:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790845371; cv=none;
 d=google.com; s=arc-20260327;
 b=aCaLbKKnES9Y70LcGYWxwO/kIVzyBa6mqB7/n4hpvzDtb8mmLhMXldtYpGl/1cg/AJ
 F+e4UaYb3aIbWB6okHLJgDL2oQWBfTG/M/LeO0AQ7Eh8KEtYwotDdKMWZa6LeEiu0Y/l
 3n00HtbaHo085dc0j3rTTAcwSWeHsDCeajGKeK+pKnySkLURz32chLJ9XtGd6jfOtvxr
 +GnnyhLLVl03/S5nMKjeVyXarStqhk/ZPtYxdue8nFkFd/FffqKaVMc/1OF8yYTg8sJN
 J0qFGMHCelLM3CkI6dvNLVqnIejpoytfIX15K87Vyeli4OlHW8Kis0gn3bmpXilLR1FJ
 +YWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MI6GM5dqgPM6FyJ98R5FH3+rrPa+Vlov2JkEwoVpZeg=;
 fh=J4t9dIlqdT7IHeqDO+0iyIK/3f9KUJv0CoudSXOI6wc=;
 b=gtNZets2kdmu6HJE2yua+OWyzSpmr7rd3Zu6CcamgPiCnzveKeBNKv+JpwwdXXTWqi
 HAcVZB0qpTxsVhWF0XsS88YfnohYMVYV1SPZVOVJksfEtsRIhn3r9VplPCdYFThEL1Lw
 Q8GxQNotg87jtisOz+6asvg4i94lTgtEwRr1WltsxhA/Lvp8aGKRtAucipFZyQI+L4S/
 3wZg/Ji66z8WNTeDNkxXPNGaqIdYwujuVhCGf57pr3t9P8gKyPOeFlqgI/7OtcWgeEmO
 pboVyJIlkAV7Fuch/WVfRMuNBqbPer85j2KGrWT9GvglJQDIctbvIA73/82PMJJCXJtV
 7bIQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790845371; x=1791450171;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MI6GM5dqgPM6FyJ98R5FH3+rrPa+Vlov2JkEwoVpZeg=;
 b=rFePtku0bittSdv/iWEe86G4KZxKDyvDpvAs6/dr0YLGJDTTHNlTCAN5u03dih8yvc
 Eykilxc2I3UNO038KHo2MoW3k0VuteHoXqOTPc7x0A0PQ3GuGhJFv4Gr3PxdNZMes+tX
 p6BLTFGLmPZ03t9Vnpw6FJ+B0qnka9yogPG31PG2GYIQ+BstVbRqJMpwnOiDWKkoxmTW
 PIWHKIV/M0PdrN6eREiyefLmZjqsQzhl71siX9MsAVAL5uqRkvougOQWXtQTctBZP+i2
 XsC1cJB4RgMpHuavMeQDlFEdaXjSsyl3e3CgHnJAp8zoT0bQ8vqhqOBI4PtLJn/oukEP
 3IbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790845371; x=1791450171;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MI6GM5dqgPM6FyJ98R5FH3+rrPa+Vlov2JkEwoVpZeg=;
 b=u2GWANGGQyNaaoM1BOO5OTY33/p0Ou7FyFG/2+zWpRgDyCe/+ebl15LViNmKJ11Sux
 smJ7t+ckr896ZO1Q+u52FQyvROJAnYa9PeQOlgaBZHuWFkkjNCI6/0KCDaNAyxYA+ZHH
 vKgW6PBFFmuxaYHX3Mn1ee4nmYt84TAzO7V5DHzVaJUPveAHegFjUvopbGnaVolya5qi
 dN9fkZ8DIaRpgeaq3dfubKMtmC2k5CDW8sh2E6tokuTaXiVuH3Yfy+VSWT4r4UOJQDBd
 NUh0kWNFB4Fo4FYHz3eKuXEToHS4a1Xm2BXoJqOPQAb81KSamAjTxrxf8cTm015AtIEb
 DG0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzKJmRJpyjKkQv12Rj+yws5UgRWIdI07bRg4mF3RDKEtopcjB8VQN8zmJNlGkXPk0KQJly5Awk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLrAeZ6ucYb5WlmjF9drx8SLTeu+cWVBcw8dsqQSP1sExby2DWy
 39Hz5J2w9BQ/ekNHN+uqsDwXY+a6Bk09mqkwbDkrIDfOzL5wyPZtZnHpuiW/HNBa6ZZ1p+dQCoj
 yYEkxH2tCLqe3+u96hkX7uj22ZJpN1u/T66gF8EikKg==
X-Gm-Gg: AYBFou250y/U2lZeKPRXDbOaURQ8Mg79y6DnUlrGFXttVItctqWRlERvxzWPrij4z4r
 DkGwI8fPLUdNX69j3/TqDbRBuwSlScTqLIUrjpeXwfHZZ7tE3XzZdrSA6AnohQpexKuRX+goAUN
 y/a6mQof4CvJutGwms1bfHLyOTInE2AAy26j66BWSGEKNDIHtGM1FBlUVHhmajcWOUKFtj6Y9sk
 hTkNz2asNUHENLlyVEvjURrkPAtAhI29HUR2VaAoH5j4yVq6rEm658Eg33A3pEVzqzoAJmyC0Nq
 qWs7yO2LoZXg03UbYXQ2lBKkC/ppHj8UBdZNuwpvZUnEe2e1STzkEbrOvVMuK0wnN6dvkI2166U
 23Uyq1eEdjsxye947EyoRtVkXwrJs3TiuVHxARceSpa9gb/nGjp24db7PbIWptMTNY3JgvvV1rI
 o2nEJ6eeI54EfXbAWHZhi2+xLoCO2rFQiL0LmW1lv4FKNzyO4SxvOGyTFV20o+9e4WsjyLD2ltO
 tSzcLLr9V/0Eb12XM+LnNJMvafM8tuwhuMAmv62gRbWXlPCNs9hw5z2YzfoWokzi/7UYIeyTUl7
 Uu5djfx6C7TIxhgxtauWxBWjTex5sjPJ1L1WCsKZH7SXySRYLUqQoGKpW2ijWN2Q97idqgOzrLv
 epIUBMWxK7PtI8JH/wp2i7O76Y7cVcXuwnT2NwvgdOYsDpUwHvmx6uQ==
X-Received: by 2002:a05:690c:630c:b0:873:5c0f:28b with SMTP id
 00721157ae682-8ac944c8b2cmr19121037b3.53.1790845371320; Thu, 01 Oct 2026
 02:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260930095948.1556020-1-anders.roxell@linaro.org>
In-Reply-To: <20260930095948.1556020-1-anders.roxell@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 1 Oct 2026 12:02:15 +0300
X-Gm-Features: AclHuK-symw5JbXw6CCxhdYOrpl3QOx52At0XqRvH3xb-8rmjVyAl_AoQgwZaAY
Message-ID: <CAC_iWjLZ4nSAmV+1yJLX5tmCJOX4BNGRo6cwyuMNengU26Ya+Q@mail.gmail.com>
Subject: Re: [PATCH] test: ut: run every suite in a comma separated list
To: Anders Roxell <anders.roxell@linaro.org>
Cc: trini@konsulko.com, sjg@chromium.org, u-boot@lists.u-boot-project.org
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

On Wed, 30 Sept 2026 at 13:00, Anders Roxell <anders.roxell@linaro.org> wrote:
>
> "ut lib,mem" only runs lib. The loop sets name to NULL after strsep(),
> but strsep() has already moved it past the comma.
>
> Loop on strsep() until it returns NULL.
>
> Fixes: fa0b68d22add ("test: Allow running a selection of suites")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  test/cmd_ut.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/test/cmd_ut.c b/test/cmd_ut.c
> index 4328670d0d67..bd9905caf518 100644
> --- a/test/cmd_ut.c
> +++ b/test/cmd_ut.c
> @@ -297,7 +297,7 @@ static int do_ut(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>                 int any_fail = 0;
>                 const char *p;
>
> -               for (; p = strsep(&name, ","), p; name = NULL) {
> +               while ((p = strsep(&name, ","))) {
>                         ste = find_suite(p);
>                         if (!ste) {
>                                 printf("Suite '%s' not found\n", p);
> --
> 2.53.0
>
