Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC81606A329
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cuIS+QJb;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W01e6nGu
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4401360A99;
	Thu, 26 Nov 2026 15:12:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w1tlz4N-2NP4; Thu, 26 Nov 2026 15:12:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3E85860A80
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795705921;
	b=jL4q3P1cclJ1w7lHEToUHqFrFcKTT9QT0BqxxcohE8QBUxZU2EAVgi6ddWrslHO+2KWm
	 uZn9CpsTvjt39eRI/Rp51GXWUvC0P3RZ4lpxeD+Ft79Jwx/+ihgPGWpNx63+qzCrsjhiL
	 hKazli4OiZCQR/p6fXAZ1TqXOBP31oXzPrEdDF1iDF9xb17w7PnjsVhzwkpSnXtdnHNkl
	 Utbx0CX6M7gborTlQn4eTNUlddFotZ7LwoKCG9vlM9xmmiMwf48ONeKUNuROm9XIkfbkO
	 T55HeVFkUYRHRwiodtcmzg4F5BdVj51+ohQ2Y6lRrRNCRbKtxT/BQQ1zuwKCIGtgXhg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795705921;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jJl7ipqORTQiVyMROzKqPn8IZ1bgc8gzEESlNa5yL8g=;
	b=WdF1uXemRaHajD13RSweBCSwZEmcWb9MrQl+XmnZ3TrNUd06o3atNFcqu68wJ9oXiFdY
	 /Fr/+2PgUGjWW0IRBM6C2nKOydbWFb7Scvm8igYJTou/NoNVxbTaOmHZqGB50xhGoOd4T
	 WRu/xFkKd/HBzQ5JSe/CuuOSmGUd55nYZxnqTwOP1vOpfbXDllufWxfhG4G3K/p7QxZwo
	 HMTmW9MwYkxRSgHxAOmBYAju36TYbL499epPxO5MCKtsbMCYZc88glEt1UTcnAQFA6HmB
	 ocx5pH6xZWS1jqxIT300JalJ3bJk5JmTnVgEwXM7xVRRcXxIiCRsvPHQaAaPRuuXi3A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795705921;
	bh=jJl7ipqORTQiVyMROzKqPn8IZ1bgc8gzEESlNa5yL8g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cuIS+QJbbJh+SdOQwRdNUnDPTLbX6+hGrlYRHCFg006xiJaWY53Cja8VGu5/4QoXT
	 DP45xTOdLmteAYjBQyxzHJjwuyDUna19A4jM2IPbeMdpieGoZyD9a3YUhPhLknjSjn
	 gzFYbXvPtAzJYXgaahPvvYbuwaKeafgF6PAWSQR4G9YUfZ8uIhbBxJ1b3VfJ5zl+1p
	 LVKl6WRX9pA1GDv6fpksNV1C0FQp1cKqvQZY258zbC6vliucmq6IjhVojEbgt0QK4i
	 g8OtmxJP8bb6/CP8q/ZT95oRGpFuagZJLn85JiqO7dPIvCMwrzSHJKZt5/6YUipWf+
	 fkiaT1nDIaP8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E85860A80;
	Thu, 26 Nov 2026 15:12:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5911910B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 15:12:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F74240503
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 15:12:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IaY-V-yHUx8x for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 15:11:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2C20B40510
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::929"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::929; helo=mail-ua1-x929.google.com;
 envelope-from=raymondmaoca@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=W01e6nGu
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2C20B40510
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 15:11:58 +0000 (UTC)
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-990a39ba4fbso1870456241.0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795705918; x=1796310718;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jJl7ipqORTQiVyMROzKqPn8IZ1bgc8gzEESlNa5yL8g=;
 b=W01e6nGu0JvB5eJlmJvDQCJdPEExa5bXeX4L/O+KeVsjhIj5nNvx5C/9giy78HDgC8
 CGHrBcxrCJMS86MwK+n9Aa05KcxvZuLg+imJUlpONxvKUA1K97I6HUHm05afu0GBD8jF
 uS8Ewemd113osV4hPTexjHcEOPOMmBps+U7ndzr8insPmGNPq4i3OWgM17wR7cPohzmc
 7eCAnswtFZ6JxFw/Z3CGfRoJFm36OwW7Tn1mTYzxbOwajl/cAEzm8/wl5jdtFgriS7z+
 iKA9joAagyRC4mi69zTzhq39gvEUiyZ/DziAmQC4xhKnDoV340Gt4EKd4dEp6B0XxdKz
 Lm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795705918; x=1796310718;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jJl7ipqORTQiVyMROzKqPn8IZ1bgc8gzEESlNa5yL8g=;
 b=Dj2NzXBIAYcWOQPgSns3O/h3nGOkkLnUkKKyPfe89Eow1P2WxPxk66g3KWpYj2ZPG0
 UcnQ/4KMF8MdVr8sPxb7eSUNSmUPpBEVJD/g1BI9Z6RoHT8AH64Ve9Tt/fN04tskSOCu
 wn+BGk/lJOGVS2Hml/JdTuUAgCDy4311idOSqc0AyyCc6ViB9LiiHtShWET77RDpj0Ug
 ++VRGseIY7SEu5vph0mAZEvj73t5cAhrFXd0uVhEzFQ0Hi0EOBKmJvEE1+qX+ReFkZXg
 pqFkXhZGtpPg+lcQBNMWyeOve+q4Jesu5KDaia8hhWbyX+reaMwlRj/zYQK6Xo9IQYZ+
 5hPA==
X-Forwarded-Encrypted: i=1;
 AL+hErFaR8mq0YcriZ94GvJMqYUNaBi4MqHpF96uufKUSg64c0P2bkFCkQASrXbVw26KwbpV6s1d5H8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/c5Itul1dagSa4y+o5/7z2EExX6K+qJWGiEdNh5LQ7lKFkMy+7
 9EYcA/1xnN7B4aWaZn7v5OOo4tLFSQBzSn6eATxopDoK/I7H5NMXZX1V9xWjniotDveiSspj4e4
 vwWUa7oCsnsVwqKBujmx+CNCw0n2DCo4=
X-Gm-Gg: AZFdTZcfiycudr85E9IoLNgVJ6QswwseR78SvWzgzssAc4+YLa6bLaq7ivHpe+fY+Zi
 XHZ4cWkY5DhIqWGuCEAmaWO3eh7afhw9VoMIVbTtA47AvPy1IxS96WESPvaeXchUMszz9MfTrpY
 MnK0emREhH5hLRyssy7knqzIKyAd5hab0Rpn8Y8ZAyF2bzb8kX3vGDYj4b3a6yT74wi7UJ1Mqm5
 qTs1c21cCz4SLykg3sR0nECxbVuNN8NsfCTMbjns+NFe00Tl1wyugxt2H86xqprpWjQKQceLJNG
 PPSaeSNATEzTSdNoAX1hb6lalPebqSFjRWUl59/9e2F1LJV5BkZkIS27fAI68zJ59eyMKc7n0Cy
 rS3nnPcOQ3uo/urVYpJo71ddkqiNYluW54nmRfw==
X-Received: by 2002:a05:6102:4186:b0:7d0:b125:79c3 with SMTP id
 ada2fe7eead31-7d73962ea7amr9849360137.26.1795705917576; Thu, 26 Nov 2026
 07:11:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104-bloblist-tl-fixes-v1-0-477121908257@baylibre.com>
 <20261104-bloblist-tl-fixes-v1-2-477121908257@baylibre.com>
In-Reply-To: <20261104-bloblist-tl-fixes-v1-2-477121908257@baylibre.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Thu, 26 Nov 2026 10:11:46 -0500
X-Gm-Features: Aa3M54qsOJohKE5xiCtn2YcDipOKqpS9UhCgJHSNinwiJo7I9S4-i5bnFSI27wU
Message-ID: <CAMDkj5xB1k9qJo1n94MfmHZUoVg3Wyw+0mKWKU8Zd8AYDZnABg@mail.gmail.com>
Subject: Re: [PATCH 2/2] bloblist: move to version 2 of the transfer list
 header
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
 Carlo Caione <ccaione@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi David,

On Wed, Nov 4, 2026 at 4:23=E2=80=AFPM David Lechner <dlechner@baylibre.com=
> wrote:
>
> Create transfer lists with header version 2, and accept lists with
> header version 1 or 2.
>
> Version 1.0 of the Firmware Handoff specification is withdrawn, because
> it specified an XOR checksum while implementations used an additive one.
> Version 2.0 went back to the additive checksum, which U-Boot already
> uses, and changed the header version to 2 without changing the layout
> of the header or the entries. Since TF-A v2.15, its transfer list
> library creates version 2 lists, which U-Boot rejects, so it loses
> everything that the earlier boot stage passed in the list.
>
> Lists with version 1 are still accepted, since existing firmware creates
> them.
>
> Link: https://github.com/FirmwareHandoff/firmware_handoff/commit/dfb62d83=
c735064291a249d802aabcf48bffb8a0
> Link: https://github.com/TF-Shared/transfer-list-library/commit/81d7f8208=
53aa117a0458ada3b9892c619233db1
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  common/bloblist.c      | 10 +++++++++-
>  include/bloblist.h     |  8 ++++++--
>  test/common/bloblist.c | 21 ++++++++++++++++++++-
>  3 files changed, 35 insertions(+), 4 deletions(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index 4ddb4a56944..90b70b06826 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -467,7 +467,15 @@ int bloblist_check(ulong addr, uint size)
>         hdr =3D map_sysmem(addr, sizeof(*hdr));
>         if (hdr->magic !=3D BLOBLIST_MAGIC)
>                 return log_msg_ret("Bad magic", -ENOENT);
> -       if (hdr->version !=3D BLOBLIST_VERSION)
> +       /*
> +        * Lists of version 1 and 2 are implemented the same way. Version=
 1.0
> +        * of the Firmware Handoff specification was withdrawn because it
> +        * specified an XOR checksum while implementations used the addit=
ive
> +        * checksum that version 2.0 specifies. Both are accepted for bac=
kwards
> +        * compatibility.
> +        */
> +       if (hdr->version !=3D BLOBLIST_VERSION &&
> +           hdr->version !=3D BLOBLIST_VERSION_WITHDRAWN)

nit:
Better to explicitly add '1' into the macro (like
BLOBLIST_VERSION_1_WITHDRAWN), as in the future, multiple withdrawn
versions can coexist.

Regards,
Raymond

>                 return log_msg_ret("Bad version", -EPROTONOSUPPORT);
>         if (!hdr->total_size || (size && hdr->total_size > size))
>                 return log_msg_ret("Bad total size", -EFBIG);
> diff --git a/include/bloblist.h b/include/bloblist.h
> index fcd290eeb16..f368a6acb85 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -76,7 +76,10 @@
>  #include <linux/errno.h>
>
>  enum {
> -       BLOBLIST_VERSION        =3D 1,
> +       /* Version of the lists supported here */
> +       BLOBLIST_VERSION        =3D 2,
> +       /* Withdrawn version 1.0 of the specification, still accepted */
> +       BLOBLIST_VERSION_WITHDRAWN =3D 1,
>         BLOBLIST_MAGIC          =3D 0x4a0fb10b,
>
>         BLOBLIST_REGCONV_SHIFT_64 =3D 32,
> @@ -179,7 +182,8 @@ enum bloblist_tag_t {
>   *     blobs can be altered after being created, this checksum is only v=
alid
>   *     when the bloblist is finalized before jumping to the next stage o=
f boot.
>   *     This is the value needed to make all checksummed bytes sum to 0
> - * @version: BLOBLIST_VERSION
> + * @version: BLOBLIST_VERSION, or BLOBLIST_VERSION_WITHDRAWN when create=
d by
> + *     another boot stage
>   * @hdr_size: Size of this header, normally sizeof(struct bloblist_hdr).=
 The
>   *     first bloblist_rec starts at this offset from the start of the he=
ader
>   * @align_log2: Power of two of the maximum alignment required by this l=
ist
> diff --git a/test/common/bloblist.c b/test/common/bloblist.c
> index ef410ca62fc..3ae5eef3859 100644
> --- a/test/common/bloblist.c
> +++ b/test/common/bloblist.c
> @@ -69,7 +69,10 @@ static int bloblist_test_init(struct unit_test_state *=
uts)
>         ut_asserteq_ptr(NULL, bloblist_check_magic(TEST_ADDR));
>         ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
>         ut_asserteq_ptr(hdr, bloblist_check_magic(TEST_ADDR));
> -       hdr->version++;
> +       hdr->version =3D BLOBLIST_VERSION + 1;
> +       ut_asserteq(-EPROTONOSUPPORT, bloblist_check(TEST_ADDR,
> +                                                    TEST_BLOBLIST_SIZE))=
;
> +       hdr->version =3D 0;
>         ut_asserteq(-EPROTONOSUPPORT, bloblist_check(TEST_ADDR,
>                                                      TEST_BLOBLIST_SIZE))=
;
>
> @@ -92,6 +95,22 @@ static int bloblist_test_init(struct unit_test_state *=
uts)
>  }
>  BLOBLIST_TEST(bloblist_test_init, UFT_BLOBLIST);
>
> +/* Test that a list of the withdrawn version is still accepted */
> +static int bloblist_test_version(struct unit_test_state *uts)
> +{
> +       struct bloblist_hdr *hdr;
> +
> +       hdr =3D clear_bloblist();
> +       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
> +       hdr->version =3D BLOBLIST_VERSION_WITHDRAWN;
> +       ut_assertok(bloblist_finish());
> +       ut_assertok(bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
> +       ut_assertnonnull(bloblist_add(TEST_TAG, TEST_SIZE, 0));
> +
> +       return 0;
> +}
> +BLOBLIST_TEST(bloblist_test_version, UFT_BLOBLIST);
> +
>  static int bloblist_test_blob(struct unit_test_state *uts)
>  {
>         struct bloblist_hdr *hdr;
>
> --
> 2.53.0
>
