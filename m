Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41881606A31B
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WwSgcYHx;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O7FsLQuy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19FC5811E5;
	Thu, 22 Oct 2026 18:40:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sPslJ2-_mRBI; Thu, 22 Oct 2026 18:40:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EF5AE811E6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792694414;
	b=iEi0Lcbvj8RJ82lDxQ9vwApIK0Zgq6up5P7rYEUIuJGlTu3DTo+6bQWkNszp5XGGhvmz
	 TuAH4Q0k+GyYRcb/ZXW+wttD9sShUQyUNm6Uoq9NOu4TYnCekqqhvinBYR0t+OoGg9kOH
	 5g56G72XV8+G952QIQARrVAgMbcwu9pbpVXxDds/g0TlOzb6t9Et/XkAIuUwBM3yLY3UC
	 r+vBOzNWrSxO0yXvyINwnfeUblCa6x6HQs5ZoFX8oaVax4Af6sW7BFgaLuW8vmvXWMGPD
	 P69Qko1Ch7GESlwA97u9trRVIDn9t2uJ7I6drHc828ijgMLDNErbfmr18m6mkkEdTXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792694414;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:Content-Language:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=//COq5PW4N+tfFRLBfr3lWgBEK4CIC6kHWumB+CJrSc=;
	b=kkQFn8jDEfg5HM+okIHcBapAuMRwSZiIcFL4Z/ppDJIbKV7eohpvprHYgdadVm1BWPTP
	 +ZBtSSfgYamUoEbL2u1kIGfArtBmsFbVowlHcQMVipAZCsLBDIZhkUUoiXiWXTokVHyqL
	 NWmWvVCiy/gkbbGF9UVdFtG1HU1rLJAJgEe/hvLTMhFYgOKAfQaMOA5zRRa8Q6xS9be0O
	 H51PdoZnHfjqJNS492FRbTk5X7B9tWrNlmknNRTvxoIJtI27gJ7HIyVrjPpwbkebqExST
	 wHxXgP4hMe8J0n8MTP7bxG8wcyqSyHJnEC5LU9dgu99N2WgqLh3teR3WZOjjnR2RP/g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792694414;
	bh=//COq5PW4N+tfFRLBfr3lWgBEK4CIC6kHWumB+CJrSc=;
	h=Date:From:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WwSgcYHxXEFZrePpngTnwFjnHMI1yBxJID1j2cHSRMKzlRKb49/wWOEWfCav9jo/6
	 Ha8sea7rfz43rEfduoSKb3Xceq+s7zweWhOK44tH3VrzpBAqH64Ajt0WU8cUh9/aeA
	 s4uSmTiJS7O+NQDdecnUn6ow1Col76lb/sHZNwMfffajEQuUQp8TCN3A/Xr5uvSSn2
	 qtyenHTRuEuXlZWTJ2yJ6idOxXUU+ce1QrjArj6PROJv3Y7GKHVEzHrtiQaFXO0e/0
	 frpi9o3fUwkh1mqbhZ2/VCOFwsBIkYQfHvDA2lehMRVMojF+qsER4ls/gQyKIZJpvJ
	 +twu0BVEs2lmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF5AE811E6;
	Thu, 22 Oct 2026 18:40:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 86BC8356
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 18:38:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 78D3440176
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 18:38:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MoUd7vDREbae for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 18:38:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3143A400B1
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792694323;
 b=LynQx9yUUsOH9LvMoB7qDQUAgUk/DbDktuQVXZ+J2ZRuHq99Q+pDBa82Lg39rNdvlnLe
 b+6NsCmFAAT7JygAXtrmQuADyKFFPZq9Z2JBe4RbZJ0WN4aeqKPHYbnQ/K7m5KsE5dmTm
 cN9xZz6VGdQRpK4m3qbfg/hCOzWHb6Jwi8tS/lfeRc24NajjkK5o5twJwfppb0XZM4bMS
 W+XeH5Cn1AQ7j7hLrFSfljA5LvJ2pEiccS+9fbAFynEflX3BFAR79lORyGhMNKWfWwykW
 5mjj/bukaJGHGaKXIuzWToRIYE40xycJR3Q1D5NaZEzMYKm0tRhRpUZiGbL9UpdoWvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792694323;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:From:Subject:To:Cc:Content-Language:
 Content-Type:Content-Transfer-Encoding;
 bh=//COq5PW4N+tfFRLBfr3lWgBEK4CIC6kHWumB+CJrSc=;
 b=je2SK2l5hCPUx9mvtcVRAbIDRIvFQKaBjX8I6nczicyVI4OHXtZm09ik41c+ol35/Eb/
 emTj5ZuiI/chmQMcqx1cp5U1JTisYtokc0zbES6n/r3qU5Fc7MJ4YSJEeUfon4DNJFgAa
 rqEBcu8454ulFaqM1r1VWGh7JeK13bhEwUT5g3FTAevy6Fe3rAbp51SaysKIVWikVTOP6
 Eg+q+3Y3qwIb586EfKsC0XoqpHGpCShntq/TyRvuhOepwWCJ0G4+a2bU+ZyJ5FGss+dRa
 HepY7/L6lrrTFrXNsxOMmNe7MkxCaovaq8GZT+Llzb6fEQDCy0R1IEDwqQPpnttIJHA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=O7FsLQuy; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=anon87111@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=O7FsLQuy
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3143A400B1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 18:38:42 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso1144665e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 11:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792694321; x=1793299121;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=//COq5PW4N+tfFRLBfr3lWgBEK4CIC6kHWumB+CJrSc=;
 b=O7FsLQuy9APUrlEO7eRQ7BbyDcCmq9ucHHPVrkOhZhxLwa40Ym1MAgeDeGMmk10TSA
 TfqhCTSpH8z8SRhnmGJGA8TBZNNDfSGj05jnzCRnb18B9BPhmtVi2naW+JcBD0EBYr4v
 PMZRUJVqsmDLc9C/T8fbcFkqUhfkCBrQu886hINmkqoB46gansK8ltPkPWQfxdtDBwID
 +DhSaLuZwGzHinhGFrtlfA0WO/lDew93sc3nyamiACyiKQO22GfpVeN05DMXvnFOXuUH
 qfEgPU/oiJF/03Elv10Ksnl87d4X1tQypHWq0OgV5IEm0j0wihaFuJbj7aWuE4HzoBd9
 +OkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792694321; x=1793299121;
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=//COq5PW4N+tfFRLBfr3lWgBEK4CIC6kHWumB+CJrSc=;
 b=mAtrbPXNH8vTjtPu7pb8KZcM2xo0jyeWfaJFj7fGQ9AM3xiizy00oyX7olRt3SZ4ex
 YN7uAzqq79yQHgfrEPDE5fH8yOvpgqeqy0S/p5n1yU6ZZnIIqoKMuRRUqbBCV6d/XZud
 1NlnbhRU/B/+1Efzj5rlJFh2vw1oUCQzDOgrL+vE+WZRCiJLM9//fUtnUESzlvc/fNzb
 XUzCYWxupDm3soaWmEv2CYnqBCZhdVETf4g9MBH7iR9kPcm51bT4sulAcFuniiKGFeaB
 3CS44QGbrWmtfY6JqKzgIQiHU0bXd74XYiuycK/Wr/25SGJBK9YSpLXr3ibpOT1ENDYu
 jaoQ==
X-Gm-Message-State: AFq9FYLZ/XUAEG0sjnXZWDJXW0xyg3Li50R0U78+UKIpfSgBOnY67ZRB
 lO+H+8A4N/kvcKUvEMotAe4Ln7SND8FonKqubFJsaGdrg60bXeUFC0XGjEkDHBxf
X-Gm-Gg: AYBFou2kNFXPDLNSUrR2QMaKm1BLh8dawIvqHyyO6GN1uVc9+YGAB6ibUxUsqaWAqq/
 MnKZ0Q1UwIv1DscGInFieyU/oltDhmBMTX23RZC22dkNcjteR8MAcBMufTe4EAA3xcyjVytu87v
 +YyESuXagEwKCWd9L7rSaKdDdvMxHGKQf3uyLrsFTJOweGP6rf6iH4b+Gi8c6qtglyyNLpve5rJ
 ZatOt5zlsoA/uFDE4P5B+n8jIx+lL0qL3HmB1c4lqWMhtJgtYKFz/hEtsvzxsJuaPckLkXy8OqQ
 HYK7wCaniOEisWjIG2zgd5xFKJW8ymNnQtab7sHLss63Cea9P52usosvo4N58M/CVscfKB8DOwx
 BBV9KI3s4Ufo2NbIMhLZUpOo+3vD5+WowxXba0oU1GlpU6XDjlgzY3D0UuQolEpIDVkJN68FNHM
 ynvqVeUFegBYiQtyCOV+48yGEw9DIwbFjQuLjz2CqgrTRPfUaZkxpdXqIH17RP6nolz4dDuPKMY
 oihqAshHYN4aDJcv370Am61WqPu5igX8ExfE4xIXnBWk6jj6sBdEe97wrzmpMw01gzKR6VOZVp4
 B4hJAg3KoRoCkWX+93IkCntUjcU=
X-Received: by 2002:a05:600c:3b8d:b0:4a1:e271:2d53 with SMTP id
 5b1f17b1804b1-4a1fd8a412amr134427035e9.3.1792694320576; 
 Thu, 22 Oct 2026 11:38:40 -0700 (PDT)
Received: from ?IPV6:2001:7e8:c647:4001:7656:3cff:fedb:3af7?
 ([2001:7e8:c647:4001:7656:3cff:fedb:3af7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e37a0f66dsm60152f8f.53.2026.10.22.11.38.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 11:38:39 -0700 (PDT)
Message-ID: <2646c589-e23d-460b-92d6-cab299fc4f56@gmail.com>
Date: Thu, 22 Oct 2026 20:38:39 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: anon87111 <anon87111@gmail.com>
Subject: [PATCH v3 0/3] image-fit-sig: bind required image keys and honour
 required-mode
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, 0xiviel@gmail.com, me@ziyao.cc
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 22 Oct 2026 18:40:12 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A key marked required = "image" in the control FDT is never bound to its
own verification. fit_image_verify_required_sigs() passes each required
key's node offset to fit_image_verify_sig(), which ignores it and calls
fit_image_check_sig() with required_keynode set to -1, documented in tree
as "any signature will do". Every required key iteration is then satisfied
by any signature verifying under any key in the FDT, so two keys marked
required = "image" collapse to one.

Patch 1 binds the key. Patch 2 adds required-mode on the image gate so the
two gates behave the same way, defaulting to "all". Patch 3 adds the
fixture and the regression test.

Changes in v3:
- add required-mode support on the image gate, default "all" (Simon Glass)
- add a regression test plus the prod hinted image fixture (Simon Glass)
- rebase from next onto main, which carries the ecdsa test rework

Changes in v2:
- add a Fixes tag (Yao Zi)
- move coordination context below the line and trim the commit message
  (Yao Zi)
---
On the anonymity question from the v2 review: pseudonymous rather than
anonymous. anon87111 is a stable identity and reachable at this address.

Verification, against main at 32eb8bb43b:

  38 passed, 0 failed in the vboot suite.
  sha256-required-image passes with patch 1 applied.
  With patch 1 reverted and patches 2 and 3 kept, it fails on the
  run_bootm(boots=False) oracle, so the test does catch the defect:
    AssertionError: assert 'sandbox: continuing, as we cannot run' not in
  sha256-pss-required and sha256-pss-pad-required still pass, so the
  configuration gate is unchanged by patch 2.

Why patch 3 adds a fixture rather than reusing the existing ones. All nine
in tree sign-images-*.its hint "dev", and
sign-configs-sha256-rsa2048-pss-prod.its is the only prod hinted file in
the tree. mkimage -g cannot redirect a hint the node already carries:
tools/image-host.c reads FIT_KEY_HINT from the node at four sites and the
-g fallback fires only when the node has no hint. So two keys both marked
required = "image" cannot be produced from the existing fixtures by any
flag.

Based on main rather than next. next is an ancestor of main and 316
commits behind it, so it is not the development tip.

Separate from "[PATCH 0/2] image-fit-sig: close the image-signature
fail-open gate", which is a control FDT with no /signature node at all.
Neither fix covers the other. Also separate from "[PATCH v10 0/7] Improve
FIT signature handling" [1], which is the configuration gate and is not
landed anywhere as of today.

[1] https://lore.kernel.org/u-boot/20260923114940.349985-1-ludwig.nussel@siemens.com/

anon87111 (3):
  image-fit-sig: bind a required image key to its own verification
  image-fit-sig: honour required-mode on the image gate
  test: vboot: cover required image keys

 boot/image-fit-sig.c                          | 35 ++++++-
 doc/usage/fit/signature.rst                   | 13 +--
 test/py/tests/test_vboot.py                   | 98 ++++++++++++++-----
 .../vboot/sign-images-sha256-rsa2048-prod.its | 42 ++++++++
 4 files changed, 154 insertions(+), 34 deletions(-)
 create mode 100644 test/py/tests/vboot/sign-images-sha256-rsa2048-prod.its

-- 
2.53.0
