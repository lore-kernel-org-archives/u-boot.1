Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E49606A31E
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 11:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sJllA+76;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=X66+gHNw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 70695812CB;
	Fri, 23 Oct 2026 11:05:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gglzV9rTiLJ9; Fri, 23 Oct 2026 11:05:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 58C52812DB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792753553;
	b=pSHnwzNLbrnv+B4v5mdExDZIRJ9sE/Jo+ydhZjccg9IhBC948LiQpXcHgwTVWibB+hh+
	 S3/A4Q6pPjtAkedF8bcJVC1IQog5iiAkCSwdnD9SjQxCm4xn/LQfU98VzIcGs1i73mPzd
	 Ml/hb5IZIuVZr3dONNu6kFmtdIh6Cc50aV2OxAa/5mTiFs7Ou4uoofud+ZE6RIEdEzOSt
	 +nbXpK93Vpaajgqe7P3RsvXGruwafKd7OkkMdkZ7b2ew87vcRIb2aIusBhShbLGmRJv6P
	 nRszVWyjay2ZW8x5mQ5x988xxez6YWu7hh++PQC/vYcx2/HpYRxMB1BpOS/skgYkyVw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792753553;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=nb5IAJd7GH7kMJZa8lFoQDlc8ol4U/KT22XiYXn2uvI=;
	b=MEoT6h+VR4qEaK12OOQd27P7sxfj9w3I89kdy3bQ2iSbckGfdj8rChxUT1PlH3R4oBUm
	 70VdHrNXzzEb2HOcbRDL/5TCMZT9I843npS8VUBO2dCD5jNmO7bmPbHfFNKZ3Uph6i2DE
	 9tw1AY1xPUYr6AiWiKNY4SKod9BAOCnePwFglNSKeWgpABwc40YkcPP92Vyw58QRe7C4X
	 +Dw6DzKEArZWZIANlGubzIOPG1nku6ABnrMOQssook3/KKm1XueG14Y1SXcTJXzAWFEAW
	 GWdiagaDVHT8hFlO/m9BJhQgCfCsWbqml4xxCLj8SPAMfTr8/1Ucv26EQpVdNVBtHZw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792753553;
	bh=nb5IAJd7GH7kMJZa8lFoQDlc8ol4U/KT22XiYXn2uvI=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sJllA+76TVxwPbZZlGUPscMIQfgK7t84veD3KBpwTx4FOsS/2VDcYs6hrBmYjBaSY
	 zpotsO/wee+ebQh14IDYV4YQKS0SOTA2RF/N+Sx3nX/5U5SYYj9jsmOaeZFjNh35WY
	 xBRIL0y7RvbK1ZRrOQz9cmTb/MgN+IrTvUE8I8ClGTmQ8yvvK1pu76TwqA0mqgj407
	 PPX7j4nNm2OgG1JgedMS1i/KifQb11iODIXm9wNDdiFY0nhnVJrrYjvn6sSTIJrTdC
	 PijT3RvxOR+PJfRdf7sXNq+5OJ+SvbRPvslPd8bSkvZp/5pmJW2MoqxsXlhRe1fI2H
	 jZoIfgJ+cvw/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58C52812DB;
	Fri, 23 Oct 2026 11:05:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 17CF33C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:05:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0961140099
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:05:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GY1Sgjbh0Mpu for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 11:05:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 07FC54008A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792753549;
 b=hCrrLvfW9UOTxZn8PZVPKOpvTmt8t/Pp3yk1eeafAEtUz00FHf02tc1Scyk+wOuRuyI1
 prsZXBOtnclkKg9r6cIpypPjP5ajZmK8d3xG/DphhyWgK1N6MshnGZEauJUG7ZRw5kz8U
 G8Zwk8cOxqvlKB3v6siOLPxHfuiEPnFqd3j+bucUWZiHK6TlrSEE1fQZag+q62SOsvDPh
 3IQdy8yQ5ky5c5+qZC6ASD2StmKcJXakInlCTMe/QDM05ixvaf+FDv8pDJHIquAHlIiDm
 wdP5S66FFzRnWaO3GIukoQ8NINAgn2hYdGFI/YpUmwekuIoVJ8qBsDHOH6awKFU/8SQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792753549;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=nb5IAJd7GH7kMJZa8lFoQDlc8ol4U/KT22XiYXn2uvI=;
 b=P2SyRLKLjiJ6VDIDoPTY2eFw+8fmEPHWoqG3LSW0hPAaHCVKIgMt59HCQQOm2sJuwZeK
 6uvqKPPjpHWl5KkkmUfzUw+zByx6bBYcv5g3FEYa5Spc8cmoCVmSrIx0kwaDgOPOsYEDb
 68DByIytksuL89RpQUtYFOyaREFQakLFEWF5kge+EkLulBeuJ9qar60Tm6/UieYFuCZAM
 y64R+Prozs8gYp/ddcNyNn321seEp/e0YKxRlp6P2U0G8t9m/Zm0erPR+kxCmXQr9dRBt
 tc/j6/4c/AQId29SMdh8BJ5ISP/Wvcb4gnd3AtEGHzHqTu+NuHuGEwvltQOAo1+Fz1w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=X66+gHNw; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=X66+gHNw
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 07FC54008A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:05:48 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6b170129413so1356081a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:05:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792753547; cv=none;
 d=google.com; s=arc-20260327;
 b=J7BujabTIfzXoBwfnfTobbt8MWUi2UeyEd663AUFXz7ZIIntAa/eLQUFepfcYa4WcO
 /fRp0aP0LcE3eF8mwXBLggkeAkA4VUCP+jgbN/WUl8g0bS2EH1ADh2pYqanhr39O0pfo
 JIpNhk+v2EzvVwO5kuofB7b+UzKVEfCBZBpWP7Ai/meDgE/F/FM6KZ3FH3AVjS0wjoJk
 zSXnmRut7Zp4rMA3vQx+rLkgBDkSUpBiJN0Ocja7JQCS3FePJcAuHtDxOKwb6FktEOQ3
 bjDTNx98okJ0UwwIJzQW7RcQZ3THrzTNSZwFWcf5CPktsmAC7cwixqsXA1LsiUdQNNSf
 q6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=nb5IAJd7GH7kMJZa8lFoQDlc8ol4U/KT22XiYXn2uvI=;
 fh=Vuv5Zf90jN4j3rjHOqKaqfQI+hGd2+CHjNpHQxl3xwU=;
 b=dJ3bMA8gLN/kBn7MhGHTiX2FyMN+6oMpvtTgLoB44k3Kj7nwdZs6W7dJ/spG3SArq9
 MiL/p/24t5nU3An/wl1wyM3RLSYGI4OjBlTvSvAQ65u0V2/LXPbVjqsnLv5JIjLdmYa4
 g0dBDh6/GlpcTS3nPfeRXBs4rKLbdzYCEdpptbkz5XJe16f8MSYgi83lnj+i0ObpCSvS
 aCJ3CsM1silvKg1jNB95wq+ORvAqZDT6GkStZ8/W14DWnMQHizUoELJ+x12G8IGLShxj
 fEymh39rACMrRftgPdE5kC8z6VDqRkFbwNzvn+ICpPUJDmHfA2Z+V1IHIK4CGQ7gLOjt
 gOOg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792753547; x=1793358347;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nb5IAJd7GH7kMJZa8lFoQDlc8ol4U/KT22XiYXn2uvI=;
 b=X66+gHNwyDkc9tBu0fYsBsT/38tPkog1VV70IDVTJGNxT3PwRsdQTM8+rc13NSGaRL
 L8MVU6h9IPKQ+3BVG87Mj+joPvDLawiPeiholMhKbWSdNW2eLOkjtm+4LrHIoaHbJDXr
 4oqhDJi3eZ2J3/Pqa01yYXvOapCDMZ7w15VG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792753547; x=1793358347;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nb5IAJd7GH7kMJZa8lFoQDlc8ol4U/KT22XiYXn2uvI=;
 b=z0fRxspgO6iDFTNskOAuB73RQJF9U6QA1ed1UhlcE73M6wJPj1IXzt8A8wYnQW6LEL
 s+cSxtVfVGn0lAt6lUTAr5KGlpN/wK4hCbpa7dOAZuvCGWkkyhpxbyDxD6al+EoTj/5H
 kERbRjt+XxHhaRSoeAgVjX5JCviD17AcuXg8aXxQmI8A6hR22FDc4SltsMrOHYjTybQ7
 PHROh8VYJMkzhVFGTS2vXuTpCOXEFpbx2galizZTmBjhvZYBl8ufHvQFxDRvJCazgn1r
 jpkQLXTKKGh3cjzIgkZcWVSpOBk8QrWpxvGmgG/rsXuuby5Q8XWkFQ37wDV1g1b1yYVy
 9scA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/lFsjdy2ra4pqhgdIgHY7hWVSGrQXQOAkzkouXRWe2EikzUxgm+z3iAHSooUf6C9dwRm/JoA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL8G4XAzPb9+/Oz7K+bHbCdBeXsy649jB81ngeXidyljAkNs3Ug
 wLJue7xy2MQFGPdi8vGjpy+NJgIjmZc7+iEveripiyADDaqPYQYsykb5blxzQqNs13rb9/YeB6D
 q9GRmrTL/UBFojH95107vFixCQBhTcUOhXVurl0pjsRjx5m6sYnHM1g==
X-Gm-Gg: AYBFou3w6e9tk9wfr5+25OexGmeOpdruQ/uMJPfLKDhCWiONpiExvJ4jsnzztI3bAdb
 Q9DxMo8K7wUlPJyJnhVjvY/CX8AC2WcWX290X+QnR183OZQIQ9y+6jfvTcN6EKQEbliRiSBeKJs
 JMeHKZi+JH0ipG4V9ySdyTeUqk20XN2Effr+1iKRFUPVQ6Jze/ZoMh9QIYnliJ6awAPhJsoZ+iE
 R1wKxpw4bDD546pM4PSiE1sJk9vJqGas0IGQY9jCuJQs+8DfU4yjlEr6g+XvTxW4yaAuBwd0euG
 6vy6H6F5lYxgoREsEhBjFN4fWdlQNZTYkBZ+exrefKlnPyJgLLtvr6cQGiM1q95mYvvqyfHJar5
 w8NCOtZrUXFaLqcmhOvPoiNeeyUdGueuaX7+IAS/bYBxpNdwFgEhfz5XY
X-Received: by 2002:a05:6402:51c8:b0:6b3:cbb1:a365 with SMTP id
 4fb4d7f45d1cf-6b432c1c58dmr3171379a12.25.1792753546828; Fri, 23 Oct 2026
 04:05:46 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 04:05:44 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 12:34:57 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261022-test-avb-fixes-v3-10-d3a6ff9ba097@kernel.org>
References: <20261022-test-avb-fixes-v3-0-d3a6ff9ba097@kernel.org>
 <20261022-test-avb-fixes-v3-10-d3a6ff9ba097@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 04:05:44 -0700
X-Gm-Features: AclHuK_YfrHFk9JaSvnSmk6sE3cUUSbkXxioNKE9QYGhhKvKjoo2kI1OoDxeHY8
Message-ID: <CAFLszThigqxEKaCXgi4xN_1wo_-1h1au0gKsav7BjtwwNBrJvw@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] test/py: avb: Fix find() logic when matching
 response strings
To: mkorpershoek@kernel.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Jan Kehren <jan.kehren@emteria.com>, Guillaume La Roque <glaroque@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-22T13:30:29, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> test/py: avb: Fix find() logic when matching response strings
>
> The AVB test suite runs some avb commands (such as "avb verify") and
> then parses the console output for success/failure.
>
> It does so by using the string.find() function which returns:
> * -1 when the substring does not exist
> * 0/a positive number when the substring exists
>
> For example, here is the output of:
> $ ./test/py/test.py --bd sandbox --build -k test_avb_verify -s -v
>
> Hit any key to stop autoboot: 0
> => =>  avb init 1
> => => avb verify
> get_partition: no MMC device at slot 1
> get_partition: no MMC device at slot 1
> avb_slot_verify.c:644: ERROR: boot: Error loading footer.
> Verification failed, reason: I/O error occurred while trying to load data
> => PASSED
>
> Here, the test is marked as PASSED because assert(-1) will return
> success.
>
> Fix the logic to fail these tests when the expected string is not found.
>
> Tested-by: Guillaume La Roque <glaroque@baylibre.com>
> Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>
>  test/py/tests/test_android/test_avb.py | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
