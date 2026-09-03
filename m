Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352CBC624A4
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 15:44:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E51E660B75;
	Thu,  3 Sep 2026 15:44:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WytvZp6mqsiI; Thu,  3 Sep 2026 15:44:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A787960B8C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788450239;
	b=kEwqzwmiDSEMzbiwswuRgM65Eb5Ztc6IOqhZ6If23aH2xlkwhERMtvJZBS7B9P7FNKdg
	 ln2A23QNxFBUjf9uVWDXxa1Nf8aG63KIsWj8SnLAqZjJC/xieS+PCIEPgmhGzdrEW/usm
	 8L1ZyM3mej1wozAbOkStVS7tDZgWquw6p71ElYUYk8S7AfZRfetE6ijCbTUqPRmkTClb9
	 TQ/9eux6nJuaOHWpZ4SA/pNbWueEaeOpC+P+ivQGw6KoUT5npQmohpR9hXTbBPKR2xFfE
	 LYr+yjyou/v6O5M3Ycv0TCwhNavuD7VX99qWplRppTMUGN4wGHkZde/eQI8eI65m2Cg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788450239;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=p8m+kK5+JHd+pq6StoPW3WpE2UwxC+UevVs7YdTLcNU=;
	b=qNQxTfa0oJx+N0ciZ8jn+xj7kROuhmALlRfAh04zkhXBa2BD4FxwesFZNHYwrDWjYH3H
	 ogjrxL2IblHX4NaCo7IOmqju6MZjX32tm4wiRoLbLWR/uqngYYOEmZJCbLiLfjFFJLmW/
	 0qRr15O7EbAMFzUV/10LtXCefXt8aIhBqHbnQP3W0NeC/9q6DtYoN1KgaFa+0s02wDoms
	 UByXWVigUz7cNhKT/mRPWSbK3ezzPoTq5BcKaCa5E/ay0q24TMB4AdK6rFMTn8pCGwTuh
	 by0b03Kqo6YK1SGWp32Wp80bniLY+NlBISlYmW3zPe/tcGz0+wQ1s18b2/nq7Hw4/Pg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NNaZAbn2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788450239;
	bh=p8m+kK5+JHd+pq6StoPW3WpE2UwxC+UevVs7YdTLcNU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HCgOibW+E968AnYyEk4otGKG5s8QhmvGR05Ura7rTZV79THDt5dMSjrNbrzPxXMlf
	 wPze6ne8nzwo1hwCIJ32EuYo5bjF4KOeBH1L0HPMCttFASUkzzrX+Ha5P7pSJnKge7
	 5EgWGFZLIixLH8CyUQMxHJYuyLLhpUb9qE7aDpDfCU7dROKEtLc6bBU0kwmI3ISgn4
	 zIvzg/YOF6NsAcz6w3CPGlkfOm/hRiwnPGIuPDFpup05vv3Vlk4i4Yjek/SBT6A3fv
	 tYSsS3ih82/BmAMwvSZ037Zg1S+cn/5l5+C2RrjzzCY25MKAxVd0jm9xgTrUVoVtJX
	 Axzo9NDwj5/uA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A787960B8C;
	Thu,  3 Sep 2026 15:43:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BDD66363
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 15:43:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B8AE260B85
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 15:43:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DGJm-imaHR7g for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 15:43:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9583860B75
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::936"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788450236;
 b=UHhvM4f7z1DjOMBoWWDiMcSUsXnsETndNaDYVXKaTqXZQd+91/g4tRzSYqhYdk4bQkpQ
 SqJRK4m+oGeiIpN4e1Crd/Vtw+EttEwBdahY6lHi0ZQZvRraMJXd7eG0Uw7rVN4qPwoKH
 mO8NyTHyWlmlTAi75JMjFQCMVbi4oa3IU9+Y/VHnpdb6mu6K7pxC9ABotE4qvzi6e7M59
 i9rPUDygj02yCn7gSeKM6IfgoikkdbGMwOfdo6oDzE2+z1GUCywMG0BSs8n3YKpGUhp5G
 DZYPw59HdgT1WbS+GZFBQucNvFUNzkN9/EjAPsWQbIpt3RmaJpO9OZD3oyiKyUr3/SQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788450236;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=p8m+kK5+JHd+pq6StoPW3WpE2UwxC+UevVs7YdTLcNU=;
 b=rT57J5HMpt0rBg0EJl0rQ2B4QDRnD17yJSQGFoBuhGopO5A4f6eP86GJzp9IAckPg8mx
 6D3BFLpU8FUmccOqLlNrRaJ0HTNzQ/ixso1OIDA6Wj4Ed6YWiyM0EoWCz2N2ZzFA0Gd/N
 Fb6Ngzhh/b89R1tg3p5PyDrlk7PIgaejFAsY6BGH297828LKe4oTM64ckntQn4QptKmB3
 eZT/5R0dIakYQF2NOkUy7iGb8qaNfGSKzweTX5VqZIW1jdWrZp4IBY0RoURvhVAoMjED5
 6DdYdAhpmGpbmN8hRoK5y8qlue4baWPafSzAHgdoj5vHoaWH2341wHnZYCj+v8TkfDg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NNaZAbn2; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::936"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::936; helo=mail-ua1-x936.google.com;
 envelope-from=raymondmaoca@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=NNaZAbn2
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com
 [IPv6:2607:f8b0:4864:20::936])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9583860B75
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 15:43:55 +0000 (UTC)
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-97e9c0da212so39207241.1
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 08:43:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788450235; cv=none;
 d=google.com; s=arc-20260327;
 b=pG7K7a3fZIjT8xIlVxhe3t5ZgWTgtmUTV+5WT5srG8+FNKQ3pTItvJgegqEO9tR3Cl
 Rpy2P0KgWSMK7XEsHOqt4nrijNR3qaa8AS2nyRNmke/TerO9qjVgYEbmT5OjDymEH818
 CodKeOP7wuR9pZnAibjyDEA9PfVP8+EVpjTm0Aeq7WTurI2ZwQaUABbzvJPpg/tJAWFX
 HakkYFvbk/y5QvyqwhHTQSzSdMmuw2o6pdMTSnDv6OP4qP59IeF2qgh3NXwlN3mFn+Xc
 AXGFMF1gxGMX3ojCO7lXCFTzBivcwOS0O99IT9IvyXV2Qe/wW4pZDnQ0DCKzrWFxKs3o
 TiVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=p8m+kK5+JHd+pq6StoPW3WpE2UwxC+UevVs7YdTLcNU=;
 fh=Lsm8LjO7LIX1MznBMW2ESh9xCl3B3SghbVUTHGKL47o=;
 b=SwL03l7BvTbJtPiWEOLTiDZUXp88ivmE2OD8qeiJnYNyOYga0N8seQPVQ/KPg4WACZ
 A92uyWViKW2DpOMWtb76lYTwSZYlI+5oDZi0KhAg9DEWfy0/iQujHuQNJFDD/jy5RwBe
 3H2M9iPZmEf4eWMwvt3KLBdzX3RFIJtlK3kq2BNoMKaynC6CMd/5jCTwamhUaREPCowF
 hPkarpr2k0vu6XjAbyndfS2vi/mpG/+6SdzYzJLRVAjPCfyrxADTGtgimkHDwjKHiWiw
 25fmUAvoQSFzUlSo04J/M8m6qZ7g7jwwxKctP10bk8hRfwRULrJ8StMvDt9IYwsSZJ7h
 yuNw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788450235; x=1789055035;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p8m+kK5+JHd+pq6StoPW3WpE2UwxC+UevVs7YdTLcNU=;
 b=NNaZAbn22l677DcgZrSOiitzkn1tZkgQd1hcCvFeiUZy1tcIl+G7c+dyj1hqPz2i+R
 i2x+1cS3pSdxE0lJpP2sXd16q6PKPWYzg7iwdJ00PpctbWi3HmMzsjpifNy9FzgG65LM
 7oIEV9nTTgBtfve7YE7XycjnnO94PgR2K0eu/oP3I0DiCNQ1FcdBlwS2rlMRJ1um7TEe
 zRPMpNLAJWI5ivialHPbDfPoRORSwNxrTb2aBnK5n8uBsubnTIfJ0j+NGKrgwci6KBHs
 DuF/GDuFacOnrcbOrzfmRQwBq6LJaTfvtOQch98jIUD0m0u/8enzdXKsckn7cTLaXK0P
 lhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788450235; x=1789055035;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p8m+kK5+JHd+pq6StoPW3WpE2UwxC+UevVs7YdTLcNU=;
 b=D8TvIQ7KbKyqw/XK7sY9M86bj629Fq53zHkgr5bOzccxrDoO8Mz00ti2UHRyfb2JlK
 itfAbZQVKyZK0JeNJiqe3mrgBCHQ9PLmvavLdsc1Zyr61P/Ws7nobzJ2iBcHybViIUAo
 D44RgxHHx34B31K9UBgXEZhyUExlSavl22Jwbq4SJRGOFX34U86xUJlzkELbZ7mnmYPr
 KZZLj9zbMjPINXx7wHZBO7/B9yktiB7fS+J4shlcAkx124h3UMTECfYwySg17i60dUpb
 ONYfxv6R0HLFW2Qpb2qgy/+dv8RnaUbBrwo02HLFEBwF9RecStxfUP+CuFzMJYOaIFjn
 Yj9A==
X-Forwarded-Encrypted: i=1;
 AKwUvByaCvpjd4G2Y/KmR0nJgnLG112mU5gAnOXHYSIbSCTizKmCgRqsH2UTtGmMCq6p6JyvTOD3rEE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++neFdxhxPdO0hZqtKB4mRuMqxRow2EbgaNTMI6KSuDukGWqmNLI
 DrIaQYnq5AWuUYx31/eHhrBXjnp/eqtsTvAAnB42PWWQZ21bF0FCNm50WhSeuLTb2YmSW6i///b
 hELbl1VxzsZO86zgvgfcBfoVyigRK3QY=
X-Gm-Gg: AYBFou0EzNGVeP0uCgzG05PKCUyvCTfz6f81/5DUxnxPaLP+w4Qnve1boUPO3K9UFT2
 Gjx2TnU6HiJbkpTV429q3q0zl12ibsnMk9C5WkIznwZAXtdI5wf2WAA/wf3x9nROcI3JAapa93T
 w/fRf1EDyVkRiNJIU/rMkCtbD4NaVI9CxaJYZOiZgBlwKfEGqBSmu4FkLHxmSSbG4AXc80ldFu7
 EVJHvTvvXa+0T2F9/eaZRoPwe45jVQQdChIsUi3GLF8rwG6rbJ6TTWYlxeDNjZY4oDy/4N8SlaD
 88FlQZtQnArntwTfm0uOHkuIBYmS+/6j8Pwz7moCPHc10AU=
X-Received: by 2002:a05:6102:5686:b0:784:a169:194a with SMTP id
 ada2fe7eead31-78a465fb040mr192886137.10.1788450234343; Thu, 03 Sep 2026
 08:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
 <20260903081705.12894-9-philippe.reynes@softathome.com>
In-Reply-To: <20260903081705.12894-9-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Thu, 3 Sep 2026 11:43:42 -0400
X-Gm-Features: AcwNN1WY3JJWgyCBVrwfXhmF5MzIVhmW7TmmJaGU5GssWf8xftOzw4rdFDLOrAk
Message-ID: <CAMDkj5xywuOB-gEkv134+HOBnOzmwy9-vu-7JUtUrgdm2N7HPg@mail.gmail.com>
Subject: Re: [PATCH v9 08/15] test: vboot: add test for ecdsa
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 simon.glass@canonical.com, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Philippe,

On Thu, Sep 3, 2026 at 4:17=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> This commit adds test case for ecdsa on fit, but not (yet) for
> the global image signature (preload).
>
> Reviewed-by: Simon Glass <simon.glass@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v2:
> - initial version
> v3:
> - no change
> v4:
> - no change
> v5:
> - no change
> v6:
> - no change
> v7:
> - no change
> v8:
> - no change
> v9:
> - some minor changes to fix rebase on next
>
>  test/py/tests/test_vboot.py                   | 29 ++++++++++++
>  .../vboot/sign-configs-sha256-ecdsa256.its    | 44 +++++++++++++++++++
>  .../vboot/sign-configs-sha256-ecdsa384.its    | 44 +++++++++++++++++++
>  .../vboot/sign-configs-sha256-ecdsa521.its    | 44 +++++++++++++++++++
>  .../vboot/sign-images-sha256-ecdsa256.its     | 42 ++++++++++++++++++
>  .../vboot/sign-images-sha256-ecdsa384.its     | 42 ++++++++++++++++++
>  .../vboot/sign-images-sha256-ecdsa521.its     | 42 ++++++++++++++++++
>  7 files changed, 287 insertions(+)
>  create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa256.its
>  create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa384.its
>  create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa521.its
>  create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa256.its
>  create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa384.its
>  create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa521.its
>

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Thanks!
Regards,
Raymond

> diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> index 33cbcea5c24..89876ff030a 100644
> --- a/test/py/tests/test_vboot.py
> +++ b/test/py/tests/test_vboot.py
> @@ -94,6 +94,9 @@ TESTDATA_IN =3D [
>      ['sha256-pss-pad', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', Fa=
lse, False, False, False],
>      ['sha256-pss-required', 'sha256', '-rsa2048', '-pss', None, True, Fa=
lse, False, False],
>      ['sha256-pss-pad-required', 'sha256', '-rsa2048', '-pss', '-E -p 0x1=
0000', True, True, False, False],
> +    ['sha256-basic-ecdsa256', 'sha256', '-ecdsa256', '', None, False, Fa=
lse, False, False],
> +    ['sha256-basic-ecdsa384', 'sha256', '-ecdsa384', '', None, False, Fa=
lse, False, False],
> +    ['sha256-basic-ecdsa521', 'sha256', '-ecdsa521', '', None, False, Fa=
lse, False, False],
>      ['sha384-basic', 'sha384', '-rsa3072', '', None, False, False, False=
, False],
>      ['sha384-pad', 'sha384', '-rsa3072', '', '-E -p 0x10000', False, Fal=
se, False, False],
>      ['algo-arg', 'algo-arg', '', '', '-o sha256,rsa2048', False, False, =
True, False],
> @@ -287,6 +290,29 @@ def test_vboot(ubman, name, sha_algo, sig_algo, padd=
ing, sign_options, required,
>          utils.run_and_log(ubman, 'openssl req -batch -new -x509 -key %s%=
s.key '
>                            '-out %s%s.crt' % (tmpdir, name, tmpdir, name)=
)
>
> +    def create_ecdsa_pair(name):
> +        """Generate a new ECDSA key pair
> +
> +        Args:
> +            name: Name of the key (e.g. 'dev')
> +        """
> +
> +        if sig_algo =3D=3D "-ecdsa256":
> +            curve_name =3D "secp256r1"
> +        elif sig_algo =3D=3D "-ecdsa384":
> +            curve_name =3D "secp384r1"
> +        elif sig_algo =3D=3D "-ecdsa521":
> +            curve_name =3D "secp521r1"
> +        else:
> +            curve_name =3D "unknownCurve"
> +
> +        utils.run_and_log(ubman, 'openssl ecparam -name %s -genkey -noou=
t -out %s%s.pem' %
> +                     (curve_name, tmpdir, name))
> +
> +        # Create a certificate containing the public key
> +        utils.run_and_log(ubman, 'openssl req -batch -new -x509 -key %s%=
s.pem '
> +                          '-out %s%s.crt' % (tmpdir, name, tmpdir, name)=
)
> +
>      def test_with_algo(sha_algo, sig_algo, padding, sign_options):
>          """Test verified boot with the given hash algorithm.
>
> @@ -570,6 +596,9 @@ def test_vboot(ubman, name, sha_algo, sig_algo, paddi=
ng, sign_options, required,
>      if sig_algo =3D=3D "-rsa2048" or sig_algo =3D=3D "-rsa3072" or sig_a=
lgo =3D=3D "":
>          create_rsa_pair('dev')
>          create_rsa_pair('prod')
> +    elif sig_algo =3D=3D "-ecdsa256" or sig_algo =3D=3D "-ecdsa384" or s=
ig_algo =3D=3D "-ecdsa521":
> +        create_ecdsa_pair('dev')
> +        create_ecdsa_pair('prod')
>
>      # Create a number kernel image with zeroes
>      with open('%stest-kernel.bin' % tmpdir, 'wb') as fd:
> diff --git a/test/py/tests/vboot/sign-configs-sha256-ecdsa256.its b/test/=
py/tests/vboot/sign-configs-sha256-ecdsa256.its
> new file mode 100644
> index 00000000000..6bd291a40c2
> --- /dev/null
> +++ b/test/py/tests/vboot/sign-configs-sha256-ecdsa256.its
> @@ -0,0 +1,44 @@
> +/dts-v1/;
> +
> +/ {
> +       description =3D "Chrome OS kernel image with one or more FDT blob=
s";
> +       #address-cells =3D <1>;
> +
> +       images {
> +               kernel {
> +                       data =3D /incbin/("test-kernel.bin");
> +                       type =3D "kernel_noload";
> +                       arch =3D "sandbox";
> +                       os =3D "linux";
> +                       compression =3D "none";
> +                       load =3D <0x4>;
> +                       entry =3D <0x8>;
> +                       kernel-version =3D <1>;
> +                       hash-1 {
> +                               algo =3D "sha256";
> +                       };
> +               };
> +               fdt-1 {
> +                       description =3D "snow";
> +                       data =3D /incbin/("sandbox-kernel.dtb");
> +                       type =3D "flat_dt";
> +                       arch =3D "sandbox";
> +                       compression =3D "none";
> +                       fdt-version =3D <1>;
> +                       hash-1 {
> +                               algo =3D "sha256";
> +                       };
> +               };
> +       };
> +       configurations {
> +               default =3D "conf-1";
> +               conf-1 {
> +                       kernel =3D "kernel";
> +                       fdt =3D "fdt-1";
> +                       signature {
> +                               algo =3D "sha256,ecdsa256";
> +                               key-name-hint =3D "dev";
> +                       };
> +               };
> +       };
> +};
> diff --git a/test/py/tests/vboot/sign-configs-sha256-ecdsa384.its b/test/=
py/tests/vboot/sign-configs-sha256-ecdsa384.its
> new file mode 100644
> index 00000000000..68c482acff2
> --- /dev/null
> +++ b/test/py/tests/vboot/sign-configs-sha256-ecdsa384.its
> @@ -0,0 +1,44 @@
> +/dts-v1/;
> +
> +/ {
> +       description =3D "Chrome OS kernel image with one or more FDT blob=
s";
> +       #address-cells =3D <1>;
> +
> +       images {
> +               kernel {
> +                       data =3D /incbin/("test-kernel.bin");
> +                       type =3D "kernel_noload";
> +                       arch =3D "sandbox";
> +                       os =3D "linux";
> +                       compression =3D "none";
> +                       load =3D <0x4>;
> +                       entry =3D <0x8>;
> +                       kernel-version =3D <1>;
> +                       hash-1 {
> +                               algo =3D "sha256";
> +                       };
> +               };
> +               fdt-1 {
> +                       description =3D "snow";
> +                       data =3D /incbin/("sandbox-kernel.dtb");
> +                       type =3D "flat_dt";
> +                       arch =3D "sandbox";
> +                       compression =3D "none";
> +                       fdt-version =3D <1>;
> +                       hash-1 {
> +                               algo =3D "sha256";
> +                       };
> +               };
> +       };
> +       configurations {
> +               default =3D "conf-1";
> +               conf-1 {
> +                       kernel =3D "kernel";
> +                       fdt =3D "fdt-1";
> +                       signature {
> +                               algo =3D "sha256,ecdsa384";
> +                               key-name-hint =3D "dev";
> +                       };
> +               };
> +       };
> +};
> diff --git a/test/py/tests/vboot/sign-configs-sha256-ecdsa521.its b/test/=
py/tests/vboot/sign-configs-sha256-ecdsa521.its
> new file mode 100644
> index 00000000000..f673accd39a
> --- /dev/null
> +++ b/test/py/tests/vboot/sign-configs-sha256-ecdsa521.its
> @@ -0,0 +1,44 @@
> +/dts-v1/;
> +
> +/ {
> +       description =3D "Chrome OS kernel image with one or more FDT blob=
s";
> +       #address-cells =3D <1>;
> +
> +       images {
> +               kernel {
> +                       data =3D /incbin/("test-kernel.bin");
> +                       type =3D "kernel_noload";
> +                       arch =3D "sandbox";
> +                       os =3D "linux";
> +                       compression =3D "none";
> +                       load =3D <0x4>;
> +                       entry =3D <0x8>;
> +                       kernel-version =3D <1>;
> +                       hash-1 {
> +                               algo =3D "sha256";
> +                       };
> +               };
> +               fdt-1 {
> +                       description =3D "snow";
> +                       data =3D /incbin/("sandbox-kernel.dtb");
> +                       type =3D "flat_dt";
> +                       arch =3D "sandbox";
> +                       compression =3D "none";
> +                       fdt-version =3D <1>;
> +                       hash-1 {
> +                               algo =3D "sha256";
> +                       };
> +               };
> +       };
> +       configurations {
> +               default =3D "conf-1";
> +               conf-1 {
> +                       kernel =3D "kernel";
> +                       fdt =3D "fdt-1";
> +                       signature {
> +                               algo =3D "sha256,ecdsa521";
> +                               key-name-hint =3D "dev";
> +                       };
> +               };
> +       };
> +};
> diff --git a/test/py/tests/vboot/sign-images-sha256-ecdsa256.its b/test/p=
y/tests/vboot/sign-images-sha256-ecdsa256.its
> new file mode 100644
> index 00000000000..009003bb601
> --- /dev/null
> +++ b/test/py/tests/vboot/sign-images-sha256-ecdsa256.its
> @@ -0,0 +1,42 @@
> +/dts-v1/;
> +
> +/ {
> +       description =3D "Chrome OS kernel image with one or more FDT blob=
s";
> +       #address-cells =3D <1>;
> +
> +       images {
> +               kernel {
> +                       data =3D /incbin/("test-kernel.bin");
> +                       type =3D "kernel_noload";
> +                       arch =3D "sandbox";
> +                       os =3D "linux";
> +                       compression =3D "none";
> +                       load =3D <0x4>;
> +                       entry =3D <0x8>;
> +                       kernel-version =3D <1>;
> +                       signature {
> +                               algo =3D "sha256,ecdsa256";
> +                               key-name-hint =3D "dev";
> +                       };
> +               };
> +               fdt-1 {
> +                       description =3D "snow";
> +                       data =3D /incbin/("sandbox-kernel.dtb");
> +                       type =3D "flat_dt";
> +                       arch =3D "sandbox";
> +                       compression =3D "none";
> +                       fdt-version =3D <1>;
> +                       signature {
> +                               algo =3D "sha256,ecdsa256";
> +                               key-name-hint =3D "dev";
> +                       };
> +               };
> +       };
> +       configurations {
> +               default =3D "conf-1";
> +               conf-1 {
> +                       kernel =3D "kernel";
> +                       fdt =3D "fdt-1";
> +               };
> +       };
> +};
> diff --git a/test/py/tests/vboot/sign-images-sha256-ecdsa384.its b/test/p=
y/tests/vboot/sign-images-sha256-ecdsa384.its
> new file mode 100644
> index 00000000000..567de687a06
> --- /dev/null
> +++ b/test/py/tests/vboot/sign-images-sha256-ecdsa384.its
> @@ -0,0 +1,42 @@
> +/dts-v1/;
> +
> +/ {
> +       description =3D "Chrome OS kernel image with one or more FDT blob=
s";
> +       #address-cells =3D <1>;
> +
> +       images {
> +               kernel {
> +                       data =3D /incbin/("test-kernel.bin");
> +                       type =3D "kernel_noload";
> +                       arch =3D "sandbox";
> +                       os =3D "linux";
> +                       compression =3D "none";
> +                       load =3D <0x4>;
> +                       entry =3D <0x8>;
> +                       kernel-version =3D <1>;
> +                       signature {
> +                               algo =3D "sha256,ecdsa384";
> +                               key-name-hint =3D "dev";
> +                       };
> +               };
> +               fdt-1 {
> +                       description =3D "snow";
> +                       data =3D /incbin/("sandbox-kernel.dtb");
> +                       type =3D "flat_dt";
> +                       arch =3D "sandbox";
> +                       compression =3D "none";
> +                       fdt-version =3D <1>;
> +                       signature {
> +                               algo =3D "sha256,ecdsa384";
> +                               key-name-hint =3D "dev";
> +                       };
> +               };
> +       };
> +       configurations {
> +               default =3D "conf-1";
> +               conf-1 {
> +                       kernel =3D "kernel";
> +                       fdt =3D "fdt-1";
> +               };
> +       };
> +};
> diff --git a/test/py/tests/vboot/sign-images-sha256-ecdsa521.its b/test/p=
y/tests/vboot/sign-images-sha256-ecdsa521.its
> new file mode 100644
> index 00000000000..74ed45b21b8
> --- /dev/null
> +++ b/test/py/tests/vboot/sign-images-sha256-ecdsa521.its
> @@ -0,0 +1,42 @@
> +/dts-v1/;
> +
> +/ {
> +       description =3D "Chrome OS kernel image with one or more FDT blob=
s";
> +       #address-cells =3D <1>;
> +
> +       images {
> +               kernel {
> +                       data =3D /incbin/("test-kernel.bin");
> +                       type =3D "kernel_noload";
> +                       arch =3D "sandbox";
> +                       os =3D "linux";
> +                       compression =3D "none";
> +                       load =3D <0x4>;
> +                       entry =3D <0x8>;
> +                       kernel-version =3D <1>;
> +                       signature {
> +                               algo =3D "sha256,ecdsa521";
> +                               key-name-hint =3D "dev";
> +                       };
> +               };
> +               fdt-1 {
> +                       description =3D "snow";
> +                       data =3D /incbin/("sandbox-kernel.dtb");
> +                       type =3D "flat_dt";
> +                       arch =3D "sandbox";
> +                       compression =3D "none";
> +                       fdt-version =3D <1>;
> +                       signature {
> +                               algo =3D "sha256,ecdsa521";
> +                               key-name-hint =3D "dev";
> +                       };
> +               };
> +       };
> +       configurations {
> +               default =3D "conf-1";
> +               conf-1 {
> +                       kernel =3D "kernel";
> +                       fdt =3D "fdt-1";
> +               };
> +       };
> +};
> --
> 2.43.0
>
