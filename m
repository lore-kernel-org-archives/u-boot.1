Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BDDCD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:03:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DB1284862;
	Mon, 25 May 2026 17:03:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KiBhDPwP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 300A28488D; Mon, 25 May 2026 17:03:41 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BC6684841
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:03:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bd85ebb368fso1416002166b.1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:03:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779721419; cv=none;
 d=google.com; s=arc-20240605;
 b=hRTrK2gLt0yy/vhsBXlOWE0abT8VjM38yq259TJ80dv+yfbI8zTX8P0W0uSgc1dQq7
 aAhMRUrVbV4HAYJL8sPe189/F83vvPW3fDqwbXNB1sc2F9LNiU6khuTaiABPt7ZLLr4A
 mdmk1IkKWYPBqFNA3KMWqLr1XGEeIhsR058PqZcWoI/nd9MEZR2K7yn1dPzUAz2fnX/R
 jm7lU3HycqdimCy93DZHvF2mRok9tsyNz7rhL4GWkwJVdlMDGCQYmdi97ZcEAA5UAt/d
 l5OFlqOPT54meTwx06fCJLKK0+cqWPQLNMKr2oGKNbximYu2ABJEL8daHbjue8m+2OR7
 P42Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YGP9eCxeD5c8l0s0IHWEAHp7dYeyLRydsfQ+hOMlRnw=;
 fh=uEwfVtgWmQ+BpqL3MMm4A4agCJ5OLHBunogpqm9TwOU=;
 b=WGuwMg14ipzuu83pLyQFiJOQzE6KZV//U+98Sw9afxJAjDCs04xc6tmxuVM/RitSni
 y3KfhpEM7FK3jcjAsjDI1xhuPrkwcKZcR55WC1RrvKlXDli45N8TeSQjlaA0P+bhaBw6
 aDeRDbwhEvPyZcq4vPH8lH3HYBzts7ydGuA5KwBqUbQkpBFYSjKolSiAbJrYO2R3Ffld
 qWs+uHZcFTTgd9ck7fZUhsBV9RBwvoJFKz0JQwhzdFzxK+4HpOywAbhIJvqp4KRSXdLn
 FlBz2hOQh0s/mWtrrTKjAW2utUPLUEg9Vcvq2caO/bP/mqdT7qxSXOmoBJICzl7dMa3s
 Tb2Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779721419; x=1780326219; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YGP9eCxeD5c8l0s0IHWEAHp7dYeyLRydsfQ+hOMlRnw=;
 b=KiBhDPwPZSJhbW0Tn+UsWm62YLuZ44kbhPrz/zMhIUU6rp+sHaz9rgw8NQNLtMIxqL
 gSfHq2E2bG1LfLzaU6XC2NCbPT15EK1Apammk5nNTTYrIsBLiWK9KoNbd6qbcgcJNxux
 /fwA6HRmn5FjT/+DeWSvSd2wQ+trPkfVBv/4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779721419; x=1780326219;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YGP9eCxeD5c8l0s0IHWEAHp7dYeyLRydsfQ+hOMlRnw=;
 b=kac2pnzSkxLd7gVqc3MyGxbVvdEyqnr/dUZmGFg373S1zK7Tn/b2xIPAdWszBEOnHe
 u4t8Sx9l87+6pLDauUNwSPHAq7ajWGU8ZpbGsOj4u0F3cYWLA5s74NRtY5Jg8FN/cs2z
 9npwm9kRf2PLpSVMfJgYw95phqcol/wr16ywSqLWkkrIKME+Iu6px/aRpKEdWcr2TUuc
 wgxGlCOdYIMKHTNvxegf75p19V3FGFkQWI75kGsGc21kDleLC162nqZe4bzArDMDm8t2
 VOlnYU1OxI6kcwND2h3+tufuDFOKz0Ls1fGPzzwtNS4n1cHx4DlsXFuQGq7mphPQjbFU
 zqvQ==
X-Gm-Message-State: AOJu0YzhuUfAOCyakwpMoDXEd3zQlJoaE+ewkGmgM4wH7sM1oEG0EXe6
 7Ru3UVmuwO55xDS05qVJ/2oEqI3jXrug3fA4atmwlUW4t2d/J1oH/NLm7aVeBJ+Lc0AVeKeOZk7
 pL2pMX8IvMWPC4s5oQZ+ElLSJsb9oclmNsk30sghCI+nRTGEbyZo=
X-Gm-Gg: Acq92OEWyMLM7gDn3QlsxT8XRHwVVrx5PoRzm3+vCg+tBWeqLoym5E0R7xWBX3aE1gX
 qb/+XzJR5mmAiYY253ppdBuc6i1+C3a/YarbXFDc8n9Ky2jIp1jVQQYBqSgpjeMEx3PQ1VtWqeQ
 jcqPgKK8kiN6OtfkLCTBdovSul1sEsEikq89kRAPQqdT3p2e5ISUq3ykQSGGrxqO1RjX26GoLDw
 8akPvjO3RQt63+LqmbXxBcR8Vg/aH4W4t4fJ7anFx3BZIXjed2+rQ/cbKDeQXMIxdIb4jAOOHZR
 tki6Lg==
X-Received: by 2002:a17:906:fe44:b0:bd8:26e5:d7a2 with SMTP id
 a640c23a62f3a-bdd236063d2mr883732666b.16.1779721418542; Mon, 25 May 2026
 08:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260522212756.3169222-1-ravi@prevas.dk>
 <20260522212756.3169222-8-ravi@prevas.dk>
In-Reply-To: <20260522212756.3169222-8-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 09:03:26 -0600
X-Gm-Features: AVHnY4JqZ9NRQchG0-yxcU19YcJV3WVOA84g8-g9w84oqnoJrraWk-ev-RxZYwg
Message-ID: <CAFLszThBb6M0Yks-Yf73HLcVMfsCOHZDS7JPpv7NRB=Hs5YNTw@mail.gmail.com>
Subject: Re: [RFC PATCH 7/9] test: avoid use of special characters in ELF
 section names
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Rasmus,

On 2026-05-22T21:27:48, Rasmus Villemoes <ravi@prevas.dk> wrote:
> test: avoid use of special characters in ELF section names
>
> While the use of the ! and ~ characters currently works, it is a bit
> hacky, and conflicts with later patches that will require the
> arguments to ll_entry_start() to be allowed at least as assembly
> identifiers.
>
> linker_lists.rst actually describes how one can do what the test
> framework wants to do: We have one 'outer' list, ut, with individual
> 'inner' lists (each suite). In order to be able to delineate the outer
> list using the ordinary ll_ helpers, we just have to make sure that
> all the inner lists use the section name ut_2_<suite> instead of
> ut_<suite>.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> include/test/test.h | 15 +++++++--------
>  test/cmd_ut.c       |  4 ++--
>  2 files changed, 9 insertions(+), 10 deletions(-)

> diff --git a/include/test/test.h b/include/test/test.h
> @@ -169,13 +169,12 @@ struct unit_test {
>
>  /* Get the start of a list of unit tests for a particular suite */
>  #define UNIT_TEST_SUITE_START(_suite) \
> -     ll_entry_start(struct unit_test, ut_ ## _suite)
> +     ll_entry_start(struct unit_test, ut_2_ ## _suite)
>  #define UNIT_TEST_SUITE_COUNT(_suite) \
> -     ll_entry_count(struct unit_test, ut_ ## _suite)
> +     ll_entry_count(struct unit_test, ut_2_ ## _suite)
>
> -/* Use ! and ~ so that all tests will be sorted between these two values */
> -#define UNIT_TEST_ALL_START()        ll_entry_start(struct unit_test, ut_!)
> -#define UNIT_TEST_ALL_END()  ll_entry_start(struct unit_test, ut_~)
> +#define UNIT_TEST_ALL_START()        ll_entry_start(struct unit_test, ut)
> +#define UNIT_TEST_ALL_END()  ll_entry_end(struct unit_test, ut)

Each suite symbol now becomes _u_boot_list_ut_2_<suite>_2_<name>, so
the regex in test/py/conftest.py (already broken by patch 5) needs
further adjusting to capture the suite correctly.

generate_ut_subtest() and the docstring above UNIT_TEST() that calls
out the strict naming convention need updating in lockstep, otherwise
test_ut.py / test_spl.py / test_vpl.py silently stop generating
subtests.

Regards,
Simon
